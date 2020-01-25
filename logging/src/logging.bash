if [[ ${BU_LOGGING} -ne 1 ]]; then
    export BU_LOGGING=1

    script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    source ${script_path}/colors.bash
    source ${script_path}/formats.bash

    function EnableRawLogging()
    {
        DisableColor
        DisableFormats
    }

    function Info() {
        echo -e "${c_green} Info: ${1}${f_reset_all}"
    }

    function Debug() {
        echo -e "${c_yellow} Debug: ${1}${f_reset_all}"
    }

    function Warning() {
        echo -e "${c_red} Warning: ${1}${f_reset_all}"
    }

    function Fatal() {
        echo -e "${f_blink}${c_red} Fatal: ${1}${f_reset_all}"
    }

    function Die()
    {
        local exit_code=${2:-1}
        Fatal "${1}"
        exit ${exit_code}
    }

fi # BU_LOGGING
