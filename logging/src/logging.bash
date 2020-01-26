if [[ ${BU_LOGGING} -ne 1 ]]; then
    BU_LOGGING=1

    script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    source ${script_path}/colors.bash
    source ${script_path}/formats.bash

    function EnableRawLogging()
    {
        DisableColor
        DisableFormats
    }

    function Info() {
        echo -e "${c_green}Info: ${f_reset_all}${@}"
    }

    function Debug() {
        echo -e "${c_yellow}Debug: ${f_reset_all}${@}"
    }

    function Warning() {
        echo -e "${c_red}Warning: ${f_reset_all}${@}"
    }

    function Fatal() {
        echo -e "${f_blink}${c_red}Fatal: ${f_reset_all}${@}"
    }

    function SetLogLevel(){
        if [[ "Info" != "${1}" || "Debug" != "${1}" || "Warning" != "${1}" || "Fatal" != "${1}" ]]; then
            Die "Not supported log level provided"
        fi

        case "${1}" in
            Info)
                log_level=3
            ;;
            Debug)
                log_level=2
            ;;
            Warning)
                log_level=1
            ;;
            Fatal)
                log_level=0
            ;;
            Disabled)
                log_level=-1
            ;;
            *)
                Die "Unsupported log level"
                exit 1
            esac

    }

    function Die()
    {
        if [[ $# -ge 3 ]]; then
            Fatal "Die function was entered with more than two parameters this is not supported!"
            exit 1
        fi
        
        local exit_code=${2:-1}
        Fatal "${1}"
        exit ${exit_code}
    }



fi # BU_LOGGING
