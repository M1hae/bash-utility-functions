#!/bin/bash
## @file			colors.bash
## @brief			Definitions of all known bash colors
## @author			Michael Zellner
## @date			07-03-2020
## @copyright		Released under the MIT
## @details         Can be used inside echo to switch the font color
if [[ ! -v BU_COLORS ]]; then
BU_COLORS=1

#Thx to https://misc.flogisoft.com/bash/tip_colors_and_formatting
# Yeah I know global variables... global variables everywhere! But lets be serious I guess you wanna use them all ;D 

declare c_black="\e[30m"
declare c_red="\e[31m"
declare c_green="\e[32m"
declare c_yellow="\e[33m"
declare c_blue="\e[34m"
declare c_magenta="\e[35m"
declare c_cyan="\e[36m"
declare c_light_grey="\e[37m"
declare c_default="\e[39m"
declare c_dark_grey="\e[90m"
declare c_light_red="\e[91m"
declare c_light_green="\e[92m"
declare c_light_yellow="\e[93m"
declare c_light_blue="\e[94m"
declare c_light_magenta="\e[95m"
declare c_light_cyan="\e[96m"
declare c_white="\e[97m"

## @fn DisableColor()
## @param none
## @retval none
## @details Disables all colors at once
function DisableColor() {
    c_black=""
    c_red=""
    c_green=""
    c_yellow=""
    c_blue=""
    c_magenta=""
    c_cyan=""
    c_light_grey=""
    c_default=""
    c_dark_grey=""
    c_light_red=""
    c_light_green=""
    c_light_yellow=""
    c_light_blue=""
    c_light_magenta=""
    c_light_cyan=""
    c_white=""
}

fi # BU_COLORS