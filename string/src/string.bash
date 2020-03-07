#!/bin/bash
## @file			string.bash
## @brief			Utility functions related to string operation
## @author			Michael Zellner
## @date			07-03-2020
## @copyright		Released under the MIT

if [[ ! -v BU_STRING ]]; then
BU_STRING=1
script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${script_path}/../../logging/src/logging.bash

function AssertNumberOfParameters() {
    if [[ ${1} -ne ${2} ]]; then
        Die "Function ${3} needs exactly ${1} parameter. You provided ${2}"
    fi
}

## @fn ToUpperCase()
## @brief Echos passed string in upper case
## @param[in] String input
function ToUpperCase() {
    echo ${1^^}
}

## @fn ToLowerCase()
## @brief Echos passed string in lower case
## @param[in] String input
function ToLowerCase() {
    echo ${1,,}
}

## @fn StringLength()
## @brief Echos length of the string
## @param[in] String input
function StringLength() {
    echo ${#1}
}

## @fn RemoveAt()
## @brief Remove character at index i from string and echos result
## @param[in] String input
## @param[in] Index i
function RemoveAt() {
    AssertNumberOfParameters 2 $# "RemoveAt"

    if [[ ${2} -ge 0 ]]; then
        echo ${1:0:${2}}${1:$(( ${2} + 1 ))}
    else
        echo ${1}
    fi
}

## @fn RemoveLast()
## @brief Remove last character from string and echos result
## @param[in] String input
function RemoveLast() {
    local string_length=$(StringLength ${1})
    RemoveAt "${1}" $(( ${string_length} - 1 ))
}

## @fn RemoveFirst()
## @brief Remove first character from string and echos result
## @param[in] String input
function RemoveFirst() {
    RemoveAt "${1}" 0
}

## @fn SplitAtReturnFirst()
## @brief Split string at index i and echos first part as result
## @param[in] String input
## @param[in] Index i
## @details Example: "bash-utility-function" 4 will return "bash"
function SplitAtReturnFirst() {
    AssertNumberOfParameters 2 $# "SplitAtReturnFirst"

    if [[ ${2} -ge 0 ]]; then
        echo ${1:0:${2}}
    else
        echo ""
    fi        
}

## @fn SplitAtReturnLast()
## @brief Split string at index i and echos last part as result
## @param[in] String input
## @param[in] Index i
## @details Example: "bash-utility-function" 4 will return "-utility-function"
function SplitAtReturnLast() {
    AssertNumberOfParameters 2 $# "SplitAtReturnLast"

    if [[ ${2} -ge 0 ]]; then
        echo ${1:${2}}
    else
        echo ${1}
    fi  
}

## @fn GetFirstChar()
## @brief Echoes first character of the string
## @param[in] String input
function GetFirstChar() {
    # We only need the first "word" of the string. Therefore ${1} is enough
    SplitAtReturnFirst "${1}" 1
}

fi # String