script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${script_path}/colors.bash
source ${script_path}/formats.bash

# Default log level set to info
bu_log_level=2

function EnableRawLogging()
{
    DisableColor
    DisableFormats
}

function Debug() {
    if [[ ${bu_log_level} -ne -1 && ${bu_log_level} -ge 3 ]]; then
        echo -e "${c_yellow}Debug: ${f_reset_all}${@}"
    fi
}

function Info() {
    echo -e "${c_green}Info: ${f_reset_all}${@}"
}

function Warning() {
    echo -e "${c_red}Warning: ${f_reset_all}${@}"
}

function Fatal() {
    echo -e "${f_blink}${c_red}Fatal: ${f_reset_all}${@}"
}

function SetLogLevel(){
    if [[ "Debug" != "${1}" && "Info" != "${1}" && "Warning" != "${1}" && "Fatal" != "${1}" && "Disabled" != "${1}" ]]; then
        Die "Not supported log level provided: ${1}"
    fi
    
    case "${1}" in
        Debug)
            bu_log_level=3
        ;;
        Info)
            bu_log_level=2
        ;;
        Warning)
            bu_log_level=1
        ;;
        Fatal)
            bu_log_level=0
        ;;
        Disabled)
            bu_log_level=-1
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

