#!/usr/bin/env bash
#
# Two-pass EBU R128 loudness normalisation for MP3 files.
#
# Usage:
#   ./mp3-loudnorm.sh [-i LUFS] [-t TP] [-l LRA] [-q VBR] [-o OUTDIR] file.mp3 [more.mp3 ...]
#   ./mp3-loudnorm.sh *.mp3
#
# Defaults: I=-16 LUFS, TP=-1.5 dBTP, LRA=11, LAME -q:a 2, output dir "normalized"
#
set -uo pipefail

TARGET_I=-16
TARGET_TP=-1.5
TARGET_LRA=11
LAME_Q=2
OUTDIR="normalized"

while getopts "i:t:l:q:o:h" opt; do
  case "$opt" in
    i) TARGET_I=$OPTARG ;;
    t) TARGET_TP=$OPTARG ;;
    l) TARGET_LRA=$OPTARG ;;
    q) LAME_Q=$OPTARG ;;
    o) OUTDIR=$OPTARG ;;
    h) sed -n '2,10p' "$0"; exit 0 ;;
    *) exit 1 ;;
  esac
done
shift $((OPTIND - 1))

if [ $# -eq 0 ]; then
  echo "No input files. Try: $0 *.mp3" >&2
  exit 1
fi

command -v ffmpeg >/dev/null || { echo "ffmpeg not found in PATH" >&2; exit 1; }
command -v ffprobe >/dev/null || { echo "ffprobe not found in PATH" >&2; exit 1; }

mkdir -p "$OUTDIR"

# Extract "key": "value" or "key": value from the loudnorm JSON block.
json_get() {
  printf '%s' "$1" | tr -d '\n' | sed -n 's/.*"'"$2"'"[[:space:]]*:[[:space:]]*"\{0,1\}\([-0-9.a-zA-Z]*\)"\{0,1\}.*/\1/p'
}

ok=0; fail=0

for f in "$@"; do
  [ -f "$f" ] || { echo "skip (not a file): $f" >&2; ((fail++)); continue; }

  base=$(basename "$f")
  out="$OUTDIR/$base"

  if [ "$(readlink -f "$f")" = "$(readlink -f "$out")" ]; then
    echo "skip (would overwrite input): $f" >&2; ((fail++)); continue
  fi

  echo "==> $base"

  # Keep the original sample rate: loudnorm works internally at 192 kHz and
  # would otherwise change the output rate.
  rate=$(ffprobe -v error -select_streams a:0 -show_entries stream=sample_rate \
         -of default=nw=1:nk=1 "$f" | head -n1)
  [ -n "$rate" ] || rate=44100

  # ---------- PASS 1: measure ----------
  stats=$(ffmpeg -hide_banner -nostdin -i "$f" \
            -af "loudnorm=I=$TARGET_I:TP=$TARGET_TP:LRA=$TARGET_LRA:print_format=json" \
            -f null - 2>&1 | awk '/^{/,/^}/')

  m_i=$(json_get "$stats" input_i)
  m_tp=$(json_get "$stats" input_tp)
  m_lra=$(json_get "$stats" input_lra)
  m_thresh=$(json_get "$stats" input_thresh)
  offset=$(json_get "$stats" target_offset)

  if [ -z "$m_i" ] || [ "$m_i" = "-inf" ] || [ -z "$m_thresh" ]; then
    echo "    measurement failed (silent or unreadable file), skipping" >&2
    ((fail++)); continue
  fi

  echo "    measured: I=$m_i LUFS  TP=$m_tp dBTP  LRA=$m_lra"

  # ---------- PASS 2: apply ----------
  # linear=true applies one flat gain and preserves dynamics; ffmpeg falls back
  # to dynamic mode automatically if that would clip the true peak.
  if ffmpeg -hide_banner -nostdin -loglevel warning -y -i "$f" \
       -af "loudnorm=I=$TARGET_I:TP=$TARGET_TP:LRA=$TARGET_LRA:\
measured_I=$m_i:measured_TP=$m_tp:measured_LRA=$m_lra:\
measured_thresh=$m_thresh:offset=$offset:linear=true:print_format=summary" \
       -ar "$rate" \
       -map 0:a -map "0:v?" -c:v copy -disposition:v attached_pic \
       -map_metadata 0 -id3v2_version 3 \
       -c:a libmp3lame -q:a "$LAME_Q" \
       "$out"; then
    echo "    -> $out"
    ((ok++))
  else
    echo "    encode failed" >&2
    ((fail++))
  fi
done

echo
echo "Done: $ok normalised, $fail skipped/failed. Output in: $OUTDIR"

