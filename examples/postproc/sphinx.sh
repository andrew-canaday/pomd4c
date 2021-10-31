#!/usr/bin/env bash
#===============================================================================
#
# sphinx.sh: Example pomd4c postprocess script to format output as RST for
#            Sphinx. (THIS IS A HACK for demonstration purposes!)
#
#-------------------------------------------------------------------------------


get_output_rst() {
    echo "${POMD4C_SOURCE}" \
        | sed 's/\.\([hc]\)/_\1.rst/'
    return
}

output_c_sig() {
    local c_doc c_code c_oneline c_type c_sig

    comment_content="$1" ; shift
    c_code="$1" ; shift
    c_oneline="$( tr '\n' ' ' <<< "${c_code}" )"

    # WARNING: HACK HACK HACK! :)
    if [[ ${c_code} == *"define"* ]]; then
        c_type="macro"
        c_sig="$( printf "%s" "${c_oneline}" \
            | sed 's/[ \t]*#[ \t]*define[ \t]\{1,\}\([A-Z_a-z0-9]\{1,\}\).*/\1/g'
        )"

    elif [[ ${c_code} == *"typedef"* ]]; then
        c_type="type"
        if [[ ${c_oneline} != *"("* ]]; then
            c_sig="$( echo "${c_oneline}" \
                | sed 's/.*[^a-z_A-Z]\([A-Za-z_0-9]\{3,\}\).*$/\1/' )"
        fi
    elif [[ ${c_code} == *"("* ]] && [[ ${c_code} != *"{"* ]]; then
        c_type="func"
        c_sig="$( sed 's/;.*//g' <<< "${c_oneline}" )"
    fi

    if [ -n "${c_type}" -a -n "${c_sig}" ]; then
        printf "\n.. c:%s::\`%s\`\n\n" \
            "${c_type}" "${c_sig}"
        printf "%s\n\n" \
            "$( echo "${comment_content}" | sed 's/^/   /g' )"
    else
        printf "\n%s\n" \
            "${comment_content}"
        printf "\n.. codehighlight::\n   %s\n\n%s\n\n" \
            ":language: c" \
            "$( echo "${c_code}" | sed 's/^/   /g' )"
    fi
}

main() {
    local comment_file source_file source_content
    comment_file="$1" ; shift
    source_file="$1"; shift

    comment_source="$( cat "${comment_file}" )"

    if [ -n "${source_file}" -a -r "${source_file}" ]; then
        source_content="$( cat "${source_file}" )"

        output_c_sig "${comment_source}" "${source_content}"
    else
        echo "${comment_source}"
    fi
}

output_rst=$( get_output_rst )
main "$@" >> ${output_rst}

