if [[ ! -v BU_PARAMETER_UTILITY ]]; then
    BU_PARAMETER_UTILITY=1

    script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    source ${script_path}/../../logging/src/logging.bash
    source ${script_path}/../../string/src/string.bash

    # Arrays to hold registered parameter within this current bash script
    declare -ag bu_parameter=("-h")
    declare -ag bu_parameter_func=("")
    declare -ag bu_parameter_help=("Display this help screen (Aliases: --h, --h, --help, -help)")
    declare -ag bu_parameter_cat=("None")

    bu_p_counter=1

    function IsHelpArgument()
    {
            [[ "${1}" = "-h" ]]    || \
            [[ "${1}" = "-help" ]] || \
            [[ "${1}" = "--h" ]]   || \
            [[ "${1}" = "--help" ]]
    }

    #
    # Register input parameter in the following pattern:
    # RegisterParameter "-i" <bash_function OR command> <help_text> <(Optional) parameter_category default: None>
    #
    function RegisterParameter()
    {
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

    #
    # Displays all registered parameter.
    # Note: You need to sort parameters by yourself! Just call RegisterParameters in your favorite order.
    #
    function DisplayHelpMessages()
    {
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

    #
    # Call this function with all parameters passed to your script. Use "${@}"!
    # Note: You need to register all you parameters first
    #
    function ProcessParameters()
    {
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