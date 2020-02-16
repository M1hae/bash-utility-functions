if [[ ! -v BU_STRING ]]; then
    BU_STRING=1
    script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    source ${script_path}/../../logging/src/logging.bash

    function AssertNumberOfParameters()
    {
        if [[ ${1} -ne ${2} ]]; then
            Die "Function ${3} needs exactly ${1} parameter. You provided ${2}"
        fi
    }

    function ToUpperCase()
    {
        echo ${1^^}
    }

    function ToLowerCase()
    {
        echo ${1,,}
    }

    function StringLength()
    {
        echo ${#1}
    }

    function RemoveAt()
    {
        AssertNumberOfParameters 2 $# "RemoveAt"

        if [[ ${2} -ge 0 ]]; then
            echo ${1:0:${2}}${1:$(( ${2} + 1 ))}
        else
            echo ${1}
        fi
    }

    function RemoveLast()
    {
        local string_length=$(StringLength ${1})
        RemoveAt "${1}" $(( ${string_length} - 1 ))
    }

    function RemoveFirst()
    {
        RemoveAt "${1}" 0
    }

    function SplitAtReturnFirst()
    {
        AssertNumberOfParameters 2 $# "SplitAtReturnFirst"

        if [[ ${2} -ge 0 ]]; then
            echo ${1:0:${2}}
        else
            echo ""
        fi        
    }

    function SplitAtReturnLast()
    {
        AssertNumberOfParameters 2 $# "SplitAtReturnLast"

        if [[ ${2} -ge 0 ]]; then
            echo ${1:${2}}
        else
            echo ${1}
        fi  
    }

    function GetFirstChar()
    {
        # We only need the first "word" of the string. Therefore ${1} is enough
        SplitAtReturnFirst "${1}" 1
    }

fi # String