if [[ ! -v BU_FILESYSTEM ]]; then
    BU_FILESYSTEM=1

    script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    source ${script_path}/../../logging/src/logging.bash

    function IsFile()
    {
        [ -f "${1}" ]
    }

    function IsDirectory()
    {
        [ -d "${1}" ]
    }

    function IsSymbolicLink()
    {
        [[ -h "${1}" ]]
    }

    function IsExisting()
    {
        IsFile "${1}" || IsDirectory "${1}" || IsSymbolicLink "${1}"
    }

    function IsReadable()
    {
        [[ -r "${1}" ]]
    }

    function IsWriteable()
    {
        [[ -w "${1}" ]]
    }

    function IsExecutable()
    {
        [[ -x "${1}" ]]
    }

    function AssertIsFile()
    {
        if ! IsFile "${1}" ;then
            Die "File ${1} does not exist"
        else
            Debug "File ${1} exists"
        fi
    }

    function AssertIsDirectory()
    {
        if ! IsDirectory "${1}" ;then
            Die "Directory ${1} does not exist"
        else
            Debug "Directory ${1} exists"
        fi
    }

    function AssertIsExisting()
    {
        Die "Not implemented yet"
        if ! IsExisting "${1}" ;then
            Die "${1} does not exist"
        else
            Debug "${1} exists"
        fi
    }

    function AssertIsSymbolicLink()
    {
        Die "Not implemented yet"
        if ! IsSymbolicLink "${1}" ;then
            Die "${1} is not a symbolic link"
        else
            Debug "${1} is a symbolic link"
        fi
    }

    function AssertIsReadable()
    {
        Die "Not implemented yet"
        if ! IsExisting "${1}" ;then
            Die "${1} is not readable"
        else
            Debug "${1} is readable"
        fi
    }

    function AssertIsWriteable()
    {
        Die "Not implemented yet"
        if ! IsWriteable "${1}" ;then
            Die "${1} is not writeable"
        else
            Debug "${1} is writeable"
        fi
    }

    function AssertIsExecutable()
    {
        Die "Not implemented yet"
        if ! IsExecutable "${1}" ;then
            Die "${1} is not executable"
        else
            Debug "${1} is executable"
        fi
    }

    function IsMoreRecent()
    {
        Die "Not implemented yet"
        [[ "${1}" -nt "${2}" ]]
    }

    function IsSameFile()
    {
        Die "Not implemented yet"
        [[ "${1}" -ef "${2}" ]]
    }

    function GetFilename()
    {
        Die "Not implemented yet"
    }

    function GetFoldername()
    {
        Die "Not implemented yet"
    }

    function GetAbsolutPath()
    {
        Die "Not implemented yet"
    }

    function GetCurrentDirectoryPath()
    {
        Die "Not implemented yet"
    }

    function WriteToFile()
    {
        Die "Not implemented yet"
    }

    function MakeDirectory()
    {
        Die "Not implemented yet"
    }

    function ReplaceInFile()
    {
        Die "Not implemented yet"
    }

    function ExistsInFile()
    {
        Die "Not implemented yet"
    }

fi