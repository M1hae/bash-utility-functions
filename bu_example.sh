#!/bin/bash

source logging/src/logging.bash
source parameter_utility/src/parameter_utility.bash


function main()
{
    Info "Welcome to main"
    
    RegisterParameter "-i" "Info" "Wrapper for the Info function" "Info"
    RegisterParameter "-f" "Fatal" "Wrapper for Fatal function" "Fatal"
    RegisterParameter "-d" "Die" "Wrapper for Die function. This will terminate with return code 1" "Die"

    ProcessParameters "$@"
}


main "$@"