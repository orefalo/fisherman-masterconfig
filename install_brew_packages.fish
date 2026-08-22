#!/usr/bin/env fish
#
# Reinstall Homebrew taps, formulae, and casks on a new machine.
# Generates a Brewfile from THIS machine's current state, then installs
# from it on the target machine.
#
# Usage:
#   Dump mode (run on your CURRENT machine to (re)generate the Brewfile):
#     ./brew_reinstall.fish dump
#
#   Install mode (run on a NEW machine that already has the Brewfile):
#     ./brew_reinstall.fish install
#
# By default the Brewfile lives next to this script as "Brewfile".

set -g script_dir (dirname (status --current-filename))
set -g brewfile "$script_dir/configs/brew/Brewfile"
set -l mode $argv[1]

if not type -q brew
    echo "Error: Homebrew is not installed. Install it first from https://brew.sh" >&2
    exit 1
end

function dump_brewfile
    echo "Dumping current Homebrew state to $brewfile ..."
    brew bundle dump --force --file="$brewfile"
    echo "Done. $brewfile now contains:"
    grep -c '^tap ' "$brewfile" | xargs echo "  taps:"
    grep -c '^brew ' "$brewfile" | xargs echo "  formulae:"
    grep -c '^cask ' "$brewfile" | xargs echo "  casks:"
end

function install_brewfile
    if not test -f "$brewfile"
        echo "Error: $brewfile not found. Run '"(status --current-filename)" dump' on the source machine first." >&2
        exit 1
    end
    echo "Installing packages from $brewfile ..."
    brew bundle install --file="$brewfile"
end

switch "$mode"
    case dump
        dump_brewfile
    case install
        install_brewfile
    case '*'
        echo "Usage: "(status --current-filename)" [dump|install]"
        exit 1
end