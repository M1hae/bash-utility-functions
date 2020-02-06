if [[ ! -v BU_PARAMETER_UTILITY ]]; then
    BU_PARAMETER_UTILITY=1

    script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    source ${script_path}/../../logging/src/logging.bash

    function RegisterParameter()
    {
        Die "Not implemented yet"
    }

    function DisplayHelpMessages()
    {
        Die "Not implemented yet"
    }

    function ProcessParameter()
    {
        Die "Not implemented yet"
    }

fi 