#!/bin/bash
## @file			filesystem.bash
## @brief			Utility functions related to file I/O 
## @author			Michael Zellner
## @date			07-03-2020
## @copyright		Released under the MIT

if [[ ! -v BU_FILESYSTEM ]]; then
BU_FILESYSTEM=1

script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${script_path}/../../logging/src/logging.bash

## @fn IsFile()
## @brief Check if path points to a file
## @param[in] String Path to the file
## @retval 0 ErrorCode Path points to a file 
## @retval 1 ErrorCode Path points not to a file 
## @details This function can be used inside an if
function IsFile() {
    [ -f "${1}" ]
}

## @fn IsDirectory()
## @brief Check if path points to a directory
## @param[in] String Path to the directory
## @retval 0 ErrorCode Path points to a directory 
## @retval 1 ErrorCode Path points not to a directory 
## @details This function can be used inside an if
function IsDirectory() {
    [ -d "${1}" ]
}

## @fn IsSymbolicLink()
## @brief Check if path points to a symbolic link
## @param[in] String Path to the symbolic link
## @retval 0 ErrorCode Path points to a symbolic link 
## @retval 1 ErrorCode Path points not to a symbolic link 
## @details This function can be used inside an if
function IsSymbolicLink() {
    [[ -h "${1}" ]]
}

## @fn IsExisting()
## @brief Check if path points to a file, directory or symbolic link
## @param[in] String Path to a file, directory or symbolic link
## @retval 0 ErrorCode Path points to a file, directory or symbolic link
## @retval 1 ErrorCode Path points not to a file, directory or symbolic link
## @details This function can be used inside an if
function IsExisting() {
    IsFile "${1}" || IsDirectory "${1}" || IsSymbolicLink "${1}"
}

## @fn IsReadable()
## @brief Check if path points to an readable file, directory or symbolic link
## @param[in] String Path to an readable file, directory or symbolic link
## @retval 0 ErrorCode Path points to an readable file, directory or symbolic link
## @retval 1 ErrorCode Path points not to an readable file, directory or symbolic link
## @details This function can be used inside an if
function IsReadable() {
    [[ -r "${1}" ]]
}

## @fn IsWriteable()
## @brief Check if path points to a writeable file, directory or symbolic link
## @param[in] String Path to a writeable file, directory or symbolic link
## @retval 0 ErrorCode Path points to a writeable file, directory or symbolic link
## @retval 1 ErrorCode Path points not to a writeable file, directory or symbolic link
## @details This function can be used inside an if
function IsWriteable() {
    [[ -w "${1}" ]]
}

## @fn IsExecutable()
## @brief Check if path points to an executable file, directory or symbolic link
## @param[in] String Path to an executable file, directory or symbolic link
## @retval 0 ErrorCode Path points to an executable file, directory or symbolic link
## @retval 1 ErrorCode Path points not to an executable file, directory or symbolic link
## @details This function can be used inside an if
function IsExecutable() {
    [[ -x "${1}" ]]
}

## @fn AssertIsFile()
## @brief Check if path points to a file if not terminate 
## @param[in] String Path to a file
## @details This function provides debug information if loglevel is set to debug
function AssertIsFile() {
    if ! IsFile "${1}" ;then
        Die "File ${1} does not exist"
    else
        Debug "File ${1} exists"
    fi
}

## @fn AssertIsDirectory()
## @brief Check if path points to a directory if not terminate 
## @param[in] String Path to a directory
## @details This function provides debug information if loglevel is set to debug
function AssertIsDirectory() {
    if ! IsDirectory "${1}" ;then
        Die "Directory ${1} does not exist"
    else
        Debug "Directory ${1} exists"
    fi
}

## @fn AssertIsExisting()
## @brief Check if path points to a file, directory or symbolic link if not terminate 
## @param[in] String Path to a file, directory or symbolic link
## @details This function provides debug information if loglevel is set to debug
function AssertIsExisting() {
    if ! IsExisting "${1}" ;then
        Die "${1} does not exist"
    else
        Debug "${1} exists"
    fi
}

## @fn AssertIsSymbolicLink()
## @brief Check if path points to a symbolic link if not terminate 
## @param[in] String Path to a symbolic link
## @details This function provides debug information if loglevel is set to debug
function AssertIsSymbolicLink() {
    if ! IsSymbolicLink "${1}" ;then
        Die "${1} is not a symbolic link"
    else
        Debug "${1} is a symbolic link"
    fi
}

## @fn AssertIsReadable()
## @brief Check if path points to an readable file, directory or symbolic link if not terminate 
## @param[in] String Path to an readable file, directory or symbolic link
## @details This function provides debug information if loglevel is set to debug
function AssertIsReadable() {
    if ! IsReadable "${1}" ;then
        Die "${1} is not readable"
    else
        Debug "${1} is readable"
    fi
}

## @fn AssertIsWriteable()
## @brief Check if path points to a writeable file, directory or symbolic link if not terminate 
## @param[in] String Path to a writeable file, directory or symbolic link
## @details This function provides debug information if loglevel is set to debug
function AssertIsWriteable() {
    if ! IsWriteable "${1}" ;then
        Die "${1} is not writeable"
    else
        Debug "${1} is writeable"
    fi
}

## @fn AssertIsExecutable()
## @brief Check if path points to an executable file, directory or symbolic link if not terminate 
## @param[in] String Path to an executable file, directory or symbolic link
## @details This function provides debug information if loglevel is set to debug
function AssertIsExecutable() {
    if ! IsExecutable "${1}" ;then
        Die "${1} is not executable"
    else
        Debug "${1} is executable"
    fi
}

## @fn GetFilename()
## @brief Not implemented yet
function GetFilename() {
    Die "${FUNCNAME[0]} not implemented yet"
}

## @fn GetFoldername()
## @brief Not implemented yet
function GetFoldername() {
    Die "${FUNCNAME[0]} not implemented yet"
}

## @fn GetAbsolutPath()
## @brief Not implemented yet
function GetAbsolutPath() {
    Die "${FUNCNAME[0]} not implemented yet"
}

## @fn ReplaceInFile()
## @brief Not implemented yet
function ReplaceInFile() {
    Die "${FUNCNAME[0]} not implemented yet"
}

## @fn ExistsInFile()
## @brief Not implemented yet
function ExistsInFile() {
    Die "${FUNCNAME[0]} not implemented yet"
}

fi