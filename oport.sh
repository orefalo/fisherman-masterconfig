#!/usr/bin/env bash
# update your bash! OSX bash is VERY old! `brew install bash``
#
# Siddharth Dushantha 2025
# Modified for macOS by using lsof instead of ss
#
# Wrapper around 'lsof' for a cleaner output of listening ports.
#

version="1.0.0-macos"

usage() {
    echo "USAGE: oports [OPTION] | [FILTER]

OPTIONS
-h, --help
        Show help
--version
        Show version

AVAILABLE FILTERS
  port    Filter by port number
  proc    Filter by process name
  pid     Filter by process ID
  ip      Filter by IP 
  user    Filter by owning user

FILTER SYNTAX
  <key>:<value>

EXAMPLE USAGES
  oports
  oports proc:nc
  oports ip:0.0.0.0

If the process belongs to another user, the process name and PID will be set
to '*' and the username will be set to '?'. Run using 'sudo' to view the values."
}

list_open_ports() {
    filter="$1"
    filter_key="${filter%:*}"
    filter_value="${filter#*:}"

    # An associative array is needed so that we can keep track of which filter
    # goes to which column. We're starting from 1 instead of 0 as 'awk' doesn't
    # have array like index.
    declare -A valid_filters=([port]=1 [proc]=2 [pid]=3 [ip]=4 [user]=5)

    # Extra padding is needed so that the underlines under the column heading
    # "User" matches the length for the longest line. 'useradd' has a maximum
    # username length of 32 characters. So by adding 32 extra whitespaces, we
    # will ensure that the underline will never be too short. It will also
    # never be too long since 'column' splits the input based on whitespace
    # and will therefore ignore any trailing whitespaces.
    extra_padding=$(printf "%*s" 32 "")

    # Use lsof to list listening TCP and UDP ports
    # -i: internet sockets
    # -P: don't convert port numbers to names
    # -n: don't convert IP addresses to hostnames
    # -sTCP:LISTEN: only show TCP sockets in LISTEN state
    # +c 0: show full command names (no truncation)
    output=$(
        {
            lsof +c 0 -iTCP -sTCP:LISTEN -P -n 2>/dev/null
            lsof +c 0 -iUDP -P -n 2>/dev/null
        } | awk 'NR > 1 && $1 != "COMMAND" {
            process = $1
            pid = $2
            user = $3
            
            # Decode \x20 hex sequences to spaces
            gsub(/\\x20/, " ", process)
            
            # Extract IP and port from the NAME column (format: *:port or IP:port)
            split($9, addr, ":")
            if (length(addr) == 2) {
                ip = addr[1]
                port = addr[2]
            } else {
                # Handle IPv6 format or other variations
                n = split($9, parts, ":")
                port = parts[n]
                ip = substr($9, 1, length($9) - length(port) - 1)
            }
            
            # Clean up IP address
            if (ip == "*") ip = "0.0.0.0"
            gsub(/\[|\]/, "", ip)  # Remove brackets from IPv6
            
            # Use tab as delimiter to preserve spacing
            print port "\t" process "\t" pid "\t" ip "\t" user
        }' | sort -n -u
    )

    if [[ -n "$filter" ]] && [[ -z "${valid_filters[$filter_key]}" ]]; then
        echo "Invalid filter: $filter_key"
        exit 1
    fi

    if [[ -n "$filter" ]]; then
        output=$(awk -F'\t' "\$${valid_filters[$filter_key]} ~ /$filter_value/" <<<"$output")
    fi

    [[ -z "$output" ]] && exit

    {
        echo -e "Port\tProcess\tPID\tIP\tUser$extra_padding"
        echo "$output"
    } | column -t -s $'\t'
}

main() {
    while [ "$1" ]; do
        case "$1" in
        --help | -h) usage && exit ;;
        --version) echo "$version" && exit ;;
        *:*) list_open_ports "$1" && exit ;;
        -*) echo "Option '$1' does not exist" && exit 1 ;;
        esac
        shift
    done

    list_open_ports
}

main "$@"