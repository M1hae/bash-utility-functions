#!/bin/bash
## @file			test_utilities.bash
## @brief			Utility functions for bats testing
## @author			Michael Zellner
## @date			07-03-2020
## @copyright		Released under the MIT

## @fn AssertStatus()
## @brief Compares passed exit code with ${status} of bats
## @param[in] Int Expected return code
function AssertStatus() {
    echo -e "Expected: ${1}\nActual: ${status}"
    [[ "${status}" -eq ${1} ]]
}

## @fn AssertOutput()
## @brief Compares passed string with ${output} of bats
## @param[in] String Expected output string
## @details Since we want to compare strings we need an ultra verbose logging output
function AssertOutput() {
    echo "Expected:"
    echo "${1}" | od -c
    echo "Actual:"
    echo "${output}" | od -c
    [[ "${output}" = "${1}" ]]
}