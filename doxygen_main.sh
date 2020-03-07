## @file			filesystem.bash
## @brief			Utility functions related to file I/O 
## @author			Michael Zellner
## @date			07-03-2020
## @copyright		Released under the MIT
## Thanks to https://wolf-u.li/5657/bash-quellcode-dokumentation-mittels-doxygen/ for this awesome guide!


#######################################################################################################################
## @mainpage 
## This code provides multiple bash utility function which are commonly used in bash script. It also introduce a better readable way of some build in bash functions
## @tableofcontents
## @section seccomponents Components
## Current available components:\n
## - logging/src/colors.bash \n
## - logging/src/formats.bash \n
## - logging/src/logging.bash \n
## - string/src/string.bash \n
## - filesystem/src/filesystem.bash \n
## - testing/test_utilities.bash \n
## - parameter_utility/src/parameter_utility.bash \n
## 
##
## @section sechowto How to use it
## Just clone it into your favorite directory and source the bash utility componente(e.g logging, filesystem, ...) you want to use.\n
## All bash utility componets are written in a way that they include the needed ones in the right way and only once! For example:\n
## ```
## #!/bin/bash
## 
## source parameter_utility/src/parameter_utility.bash
## 
## function main()
## {
##     Info "Welcome to main"
##     
##     RegisterParameter "-i" "Info" "Wrapper for the Info function" "Info"
##     RegisterParameter "-f" "Fatal" "Wrapper for Fatal function" "Fatal"
##     RegisterParameter "-d" "Die" "Wrapper for Die function. This will terminate with return code 1" "Die"
## 
##     ProcessParameters "$@"
## }
## 
## main "$@"
## ```
## This script(bu_example.sh) is also commited in the main directory. To see the help text use:\n
## ```
## ./bu_example.sh -h
## ```
##
## Print info:\n
## ```
## ./bu_example.sh -i "My info message"
## ```
## Analog behavior can be expected for -f and -d. Of course with different output ;D...
##################################################################