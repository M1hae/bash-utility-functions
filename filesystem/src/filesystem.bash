if [[ ! -v BU_FILESYSTEM ]]; then
    BU_FILESYSTEM=1

    script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    source ${script_path}/../../logging/src/logging.bash

    function IsFile()
    {
        [[ -f "${1}" ]]
    }

    function IsDirectory()
    {
        [[ -d "${1}" ]]
    }

    function AssertIsFile()
    {
        if ! IsFile ${1} ;then
        {
            Fatal "File ${1} does not exists"
        }
    }

    function AssertIsDirectory()
    {
        if ! IsDirectory ${1} ;then
        {
            Fatal "Directory ${1} does not exists"
        }
    }

    function IsExisting()
    {
        [[ -e "${1}" ]]
    }

    function IsReadable()
    {
        [[ -r "${1}" ]]
    }

    function IsSymbolicLink()
    {
        [[ -h "${1}" ]]
    }

    function IsWriteable()
    {
        [[ -w "${1}" ]]
    }

    function IsExecutable()
    {
        [[ -x "${1}" ]]
    }

    function IsMoreRecent()
    {
        [[ "${1}" -nt "${2}" ]]
    }

    function IsSameFile()
    {
        [[ "${1}" -ef "${2}" ]]
    }

    function GetFilename()
    {

    }

    function GetFoldername()
    {

    }

    function GetAbsolutPath()
    {

    }

    function GetCurrentDirectoryPath()
    {

    }

    function WriteToFile()
    {

    }

    function MakeDirectory()
    {

    }

    function ReplaceInFile()
    {

    }

    function ExistsInFile()
    {
        
    }



fi