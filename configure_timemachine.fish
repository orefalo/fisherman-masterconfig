#!/usr/bin/env fish
#
# tm-mail-exclude.fish
#
# Adds or removes Time Machine path exclusions for the directories that
# generate the most FSEvents on a typical Mac: the Outlook profile store,
# the Apple Mail message store, and cloud sync folders. All of these hold
# one file per message, attachment or synced object, so they turn into
# millions of entries that get re-walked on every deep scan.
#
# Defaults to a dry run. Nothing changes until you pass --apply.
#
#   ./tm-mail-exclude.fish                    # preview
#   ./tm-mail-exclude.fish --status           # current exclusion state
#   ./tm-mail-exclude.fish --count            # preview + file counts (slow)
#   ./tm-mail-exclude.fish --apply            # add exclusions
#   ./tm-mail-exclude.fish --apply --keep-maildata
#   ./tm-mail-exclude.fish --apply --remove   # undo
#   ./tm-mail-exclude.fish --apply --restart  # add, then restart the backup
#
# Scope flags: --no-outlook, --no-mail, --no-cloud, --icloud
#
# --keep-maildata excludes each Mail account directory individually and leaves
# ~/Library/Mail/VN/MailData backed up, so rules, signatures, smart mailboxes
# and account settings survive a restore.
#
# --icloud additionally excludes ~/Library/Mobile Documents. Off by default:
# if Desktop & Documents syncing is on, your Desktop and Documents live there.

set -g OUTLOOK_DIR "$HOME/Library/Group Containers/UBF8T346G9.Office/Outlook"
set -g MAIL_DIR "$HOME/Library/Mail"
set -g MAIL_CONTAINER "$HOME/Library/Containers/com.apple.mail"
set -g CLOUD_DIR "$HOME/Library/CloudStorage"
set -g ICLOUD_DIR "$HOME/Library/Mobile Documents"
set -g LEGACY_CLOUD "$HOME/Dropbox" "$HOME/Google Drive" "$HOME/OneDrive"

function usage
    sed -n '3,31p' (status filename) | string replace -r '^#\s?' ''
end

function is_excluded -a path
    set -l out (tmutil isexcluded "$path" 2>/dev/null)
    string match -qr '^\[Excluded\]' -- $out
end

# Mailboxes under "On My Mac" and POP accounts live nowhere but this disk.
# Flag them before anything gets excluded.
function check_local_mail
    set -l warnings

    for vdir in $MAIL_DIR/V*
        test -d "$vdir/Mailboxes"; or continue
        set -l n (ls -1 "$vdir/Mailboxes" 2>/dev/null | wc -l | string trim)
        test "$n" -gt 0; and set -a warnings "$n local \"On My Mac\" mailbox(es) in "(basename "$vdir")
    end

    set -l olm (find "$HOME" -maxdepth 3 -name '*.olm' 2>/dev/null | wc -l | string trim)
    test "$olm" -gt 0; and set -a warnings "$olm .olm archive(s) near your home directory"

    if test (count $warnings) -gt 0
        echo "Local-only mail data detected:"
        for w in $warnings
            echo "  ! $w"
        end
        echo "  These exist on no server. Excluding them removes them from your backups."
        echo
    end
end

# Excluding a sync folder means the vendor's cloud becomes your only copy.
# That covers disk failure but not a sync error or a deletion that propagates.
function check_cloud
    set -l warnings

    if set -q _flag_icloud
        if test -L "$HOME/Desktop"; or test -L "$HOME/Documents"
            set -a warnings "Desktop & Documents syncing is ON: those folders live inside iCloud Drive"
        end
    end

    for d in $CLOUD_DIR/*
        test -d "$d"; or continue
        set -a warnings (basename "$d")": only copy becomes the provider's cloud"
    end

    if test (count $warnings) -gt 0
        echo "Cloud storage notes:"
        for w in $warnings
            echo "  ! $w"
        end
        echo "  Check that your provider's version history window is long enough"
        echo "  to cover how long a bad change might go unnoticed."
        echo
    end
end

function build_targets
    set -l targets

    if not set -q _flag_no_outlook
        test -d "$OUTLOOK_DIR"; and set -a targets "$OUTLOOK_DIR"
    end

    if not set -q _flag_no_mail
        if test -d "$MAIL_DIR"
            if set -q _flag_keep_maildata
                for vdir in $MAIL_DIR/V*
                    test -d "$vdir"; or continue
                    for acct in $vdir/*
                        test -d "$acct"; or continue
                        # Account stores are named with a UUID. MailData is not.
                        if string match -qr '^[0-9A-Fa-f]{8}-' -- (basename "$acct")
                            set -a targets "$acct"
                        end
                    end
                end
            else
                set -a targets "$MAIL_DIR"
            end
        end
        test -d "$MAIL_CONTAINER"; and set -a targets "$MAIL_CONTAINER"
    end

    if not set -q _flag_no_cloud
        # File Provider era: Dropbox, Google Drive, OneDrive, Box all land here.
        # Listed one provider at a time so you can see and skip individually.
        for d in $CLOUD_DIR/*
            test -d "$d"; and set -a targets "$d"
        end

        # Pre-File-Provider installs that still sync into the home directory.
        for d in $LEGACY_CLOUD
            test -d "$d"; and not test -L "$d"; and set -a targets "$d"
        end

        set -q _flag_icloud; and test -d "$ICLOUD_DIR"; and set -a targets "$ICLOUD_DIR"
    end

    for t in $targets
        echo "$t"
    end
end

argparse h/help a/apply r/remove s/status c/count k/keep-maildata \
    no-outlook no-mail no-cloud icloud restart -- $argv
or exit 1

if set -q _flag_help
    usage
    exit 0
end

set -l targets (build_targets)

if test (count $targets) -eq 0
    echo "Nothing to do: no matching directories found."
    exit 0
end

if set -q _flag_status
    for t in $targets
        if is_excluded "$t"
            echo "excluded  $t"
        else
            echo "included  $t"
        end
    end
    exit 0
end

set -l verb add
set -q _flag_remove; and set verb remove

# Preview
if not set -q _flag_apply
    check_local_mail
    check_cloud
    echo "Dry run. Would $verb these exclusions:"
else
    if not set -q _flag_remove
        check_local_mail
        check_cloud
    end
    echo "Applying: $verb exclusions"
end
echo

for t in $targets
    set -l state included
    is_excluded "$t"; and set state excluded

    if set -q _flag_count
        set -l n (find "$t" 2>/dev/null | wc -l | string trim)
        printf "  [%s] %s files  %s\n" $state $n "$t"
    else
        printf "  [%s] %s\n" $state "$t"
    end
end
echo

if not set -q _flag_apply
    echo "Re-run with --apply to $verb these."
    exit 0
end

if test (id -u) -ne 0
    echo "tmutil needs root to write the exclusion list."
    echo "Re-running under sudo."
    echo
    exec sudo fish (status filename) $argv
end

set -l changed 0
for t in $targets
    if set -q _flag_remove
        if tmutil removeexclusion -p "$t" 2>/dev/null
            echo "removed   $t"
            set changed (math $changed + 1)
        else
            echo "failed    $t"
        end
    else
        if tmutil addexclusion -p "$t" 2>/dev/null
            echo "excluded  $t"
            set changed (math $changed + 1)
        else
            echo "failed    $t"
        end
    end
end

echo
echo "$changed path(s) changed."

if set -q _flag_restart
    echo "Restarting backup so the new list takes effect."
    tmutil stopbackup
    sleep 3
    tmutil startbackup
    echo "Watch progress with: tmutil status"
else
    echo "Exclusions apply to the next backup. To apply now:"
    echo "  tmutil stopbackup; and tmutil startbackup"
end