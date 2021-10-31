#!/usr/bin/env bash
#===============================================================================
#
# verbose.sh: Example pomd4c postprocess script to demonstrate inputs.
#
#-------------------------------------------------------------------------------

__thisname="${0##*/}"

# NOTE: in case the caller is using redirect, we log to stderr!
proc_log() {
    local fmt
    fmt=$1 ; shift
    printf "${fmt}\n" "$@" >&2
}

main() {
    local comment_file source_file
    comment_file="$1" ; shift
    source_file="$1" ; shift

    proc_log "\n\n%s" "===================================================="

    # Show the input args:
    proc_log "%s invoked with args:" "${__thisname}"
    proc_log "  ${comment_file} (comment file)"
    proc_log "  ${source_file}  (source file)"

    # Show the context (env):
    proc_log "Env context:"
    env \
        | grep '^POMD4C_\w\{1,\}' \
        | sed 's/^/  /g' \
        >&2

    proc_log "Comment:\n%s" "$( cat ${comment_file} \
        | sed 's/^/    /g'
        )"

    if [ -n "${source_file}" ]; then
        proc_log "Source:\n%s" "$( cat ${source_file} )"
    fi

    proc_log "%s\n" '----------------------------------------------------'
}

main "$@"

