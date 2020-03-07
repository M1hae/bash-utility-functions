## @file			logging.bash
## @brief			Definitions of logging mechanismns
## @author			Michael Zellner
## @date			07-03-2020
## @copyright		Released under the MIT

if [[ ! -v BU_LOGGING ]]; then
BU_LOGGING=1

script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${script_path}/colors.bash
source ${script_path}/formats.bash

# Default log level set to info
bu_log_level=2

## @fn EnableRawLogging()
## @brief Disables all colors and formats
## @details Internally calls \b DisableColor and \b DisableFormats
function EnableRawLogging() {
    DisableColor
    DisableFormats
}

## @fn Debug()
## @brief Output debug message
## @param[in] String Message to the user
## @details Display debug text if log level is set to: \b Debug
function Debug() {
    if [[ ${bu_log_level} -ne -1 && ${bu_log_level} -ge 3 ]]; then
        echo -e "${c_yellow}Debug: ${f_reset_all}${@}"
    fi
}

## @fn Info()
## @brief Output info message
## @param[in] String Message to the user
## @details Display info text if log level is set to: \b Debug or \b Info
function Info() {
    if [[ ${bu_log_level} -ne -1 && ${bu_log_level} -ge 2 ]]; then
        echo -e "${c_green}Info: ${f_reset_all}${@}"
    fi
}

## @fn Warning()
## @brief Output warning message
## @param[in] String Message to the user
## @details Display warning text if log level is set to: \b Debug, \b Info or \b Warning
function Warning() {
    if [[ ${bu_log_level} -ne -1 && ${bu_log_level} -ge 1 ]]; then
        echo -e "${c_red}Warning: ${f_reset_all}${@}"
    fi
}

## @fn Fatal()
## @brief Output fatal message
## @param[in] String Message to the user
## @details Display fatal text if log level is set to: \b Debug, \b Info, \b Warning or \b Fatal
function Fatal() {
    if [[ ${bu_log_level} -ne -1 && ${bu_log_level} -ge 0 ]]; then
        echo -e "${f_blink}${c_red}Fatal: ${f_reset_all}${@}"
    fi
}

## @fn SetLogLevel()
## @brief Switch log level
## @param[in] String Supported log levels: \b Debug, \b Info, \b Warning, \b Fatal or \b Disabled
## @retval Errorcode 1 Unsupported log level
## @details Switch log level to the passed one
function SetLogLevel() {
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
        esac
}

## @fn Die()
## @brief Terminate script
## @param[in] String User defined error text
## @param[in] Int (Optional) User defined exit code otherwise 1
## @retval Errorcode 1 or ${2}
## @details Terminates the script, prints an error message and optionally sets the exit code
function Die() {
    if [[ $# -ge 3 ]]; then
        Fatal "Die function was entered with more than two parameters this is not supported!"
        exit 1
    fi
    
    local exit_code=${2:-1}
    Fatal "${1}"
    exit ${exit_code}
}

fi # BU_LOGGING