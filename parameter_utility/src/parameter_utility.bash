#!/bin/bash
## @file			parameter_utility.bash
## @brief			Utility functions for script parameter handling
## @author			Michael Zellner
## @date			07-03-2020
## @copyright		Released under the MIT

if [[ ! -v BU_PARAMETER_UTILITY ]]; then
BU_PARAMETER_UTILITY=1

script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${script_path}/../../logging/src/logging.bash
source ${script_path}/../../string/src/string.bash


## @brief Array to hold all parameters. IMPORTANT: Do not change the order of this
declare -ag bu_parameter=("-h")

## @brief Array to hold all bash functions. IMPORTANT: Do not change the order of this
declare -ag bu_parameter_func=("")

## @brief Array to hold all help text strings. IMPORTANT: Do not change the order of this
declare -ag bu_parameter_help=("Display this help screen (Aliases: --h, --h, --help, -help)")

## @brief Array to hold all categories of the parameters. IMPORTANT: Do not change the order of this
declare -ag bu_parameter_cat=("None")

## @brief Counter for already registered parameters
declare bu_p_counter=1

## @fn IsHelpArgument()
## @brief Check if the passed string fits "-h", "-help", "--h", "--help"
## @retval Errorcode 0 input fits the restrictions
## @retval Errorcode 1 input is something else
## @param[in] String input
function IsHelpArgument() {
        [[ "${1}" = "-h" ]]    || \
        [[ "${1}" = "-help" ]] || \
        [[ "${1}" = "--h" ]]   || \
        [[ "${1}" = "--help" ]]
}

## @fn RegisterParameter()
## @brief Register parameters
## @retval Errorcode 0 input fits the restrictions
## @retval Errorcode 1 input is something else
## @param[in] String Parameter (e.g -i)
## @param[in] String Bash command or function (e.g. echo)
## @param[in] String Help text
## @param[in] String (Optional) Category default: None
## @details Register input parameter in the following pattern:\n
## RegisterParameter <\b Parameter> <\b Function/Command> <\b Help \b text> <\b Category>\n
## \n
## E.g.:\n
## RegisterParameter "-i" "echo" "Wrapper for echo"\n
## RegisterParameter "-i" "echo" "Wrapper for echo" "General"\n
## \n
## \b NOTE:\n
##       - You cannot register -h, -help, --h, --help because it is used for the help screen\n
##       - You need to sort the parameters yourself
function RegisterParameter() {
    if  ( ! [[ $# -eq 3 ]] && ! [[ $# -eq 4 ]]); then
        Warning "RegisterParameter: Received $#  $@"
        Die "Please provide at least three parameters e.g: \nRegisterParameter \"-i\" <my_bash_function> <my_help_text> <(Optional)parameter_category>" 
    fi
    
    if IsHelpArgument "${1}" ; then
        Die "${1} is reserved for the help screen"
    fi

    bu_parameter[${bu_p_counter}]="${1}"
    bu_parameter_func[${bu_p_counter}]="${2}"
    bu_parameter_help[${bu_p_counter}]="${3}"  

    if [[ $# -eq 4 ]]; then     
        bu_parameter_cat[${bu_p_counter}]="${4}"
    else
        bu_parameter_cat[${bu_p_counter}]="None"        
    fi

    bu_p_counter=$((bu_p_counter+1))
}

## @fn DisplayHelpMessages()
## @brief Displays all registered parameter
## @details You need to sort parameters by yourself! Just call RegisterParameters in your favorite order
function DisplayHelpMessages() {
    if [[ $# -ne 0 ]]; then
        Die "DisplayHelpMessages called with parameters! This is not supported!"
    fi

    local help_text="The following parameters are supported within this script:\n"
    local current_category=""

    for i in "${!bu_parameter[@]}"; do
        if [[ "${current_category}" != ${bu_parameter_cat[${i}]} ]]; then
            current_category=${bu_parameter_cat[${i}]}
            help_text+="\nCategory ${current_category}:\n"
        fi
        help_text+="   ${bu_parameter[$i]} - ${bu_parameter_help[$i]}\n"
        Debug "Parameter ${bu_parameter[$i]} is going to execute: ${bu_parameter_func[$i]}"
    done

    Info "${help_text}"
}

## @fn ProcessParameters()
## @brief Process all registered parameters and call their bash functions
## @param[in] String All input parameter of your script.
## @details Call this function with all parameters passed to your script. Usually this is "${@}"\n
## \b Note:\n
## You need to register all you parameters first
function ProcessParameters() {
    # Initial check if help screen is required by the user
    for para in "${@}"; do
        if IsHelpArgument "${para}" ; then
            DisplayHelpMessages 
            exit 0
        fi
    done

    for (( i=1; i <= "$#"; i++ )); do
        local para_counter=0
        argument=${!i}

        Debug "Process input ${argument}"

        for j in "${!bu_parameter[@]}"; do
            if [[ "${bu_parameter[${j}]}" = "${argument}" ]]; then
                Debug "Found ${bu_parameter[${j}]}"
                Debug "Lets try to find a potencial argument"
                
                next_arg_index=$((i+1))
                additional_parameter=""

                if [[ ${i} -lt $# ]]; then
                    first_char_next_arg=$(GetFirstChar ${!next_arg_index}})

                    if [[ ${first_char_next_arg} != "-" ]]; then
                        Debug "Found additional parameter ${!next_arg_index}"
                        additional_parameter=${!next_arg_index}
                        i=$((i+1))
                    fi
                fi

                Debug "Execute bash function or command \"${bu_parameter_func[${j}]}\" with ${additional_parameter}"
                eval "${bu_parameter_func[${j}]} \"${additional_parameter}\"" || Die "Execution of \"${bu_parameter_func[${j}]} ${additional_parameter}\" failed! Please check your RegisterParameter section"
                
                Debug "Done"
                additional_parameter=""
                break
            fi
            para_counter=$((para_counter+1))
        done

        if [[ ${#bu_parameter[@]} -eq ${para_counter} ]]; then
            Die "Could not find ${!i}! You need to register it first with RegisterParameter"
        fi
    done
}

fi 