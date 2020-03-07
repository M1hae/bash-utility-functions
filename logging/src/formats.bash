#!/bin/bash
## @file			formats.bash
## @brief			Definitions of all known bash formats
## @author			Michael Zellner
## @date			07-03-2020
## @copyright		Released under the MIT
## @details         Can be used inside echo to switch the font formats

if [[ ! -v BU_FORMATS ]]; then
BU_FORMATS=1

#Thx to https://misc.flogisoft.com/bash/tip_colors_and_formatting
# Yeah I know global variables... global variables everywhere! But lets be serious I guess you wanna use them all ;D 

declare f_bold="\e[1m"
declare f_dim="\e[2m"
declare f_underlined="\e[4m"
declare f_blink="\e[5m"
declare f_reverse="\e[7m"
declare f_hidden="\e[8m"
declare f_reset_all="\e[0m"
declare f_reset_bold="\e[21m"
declare f_reset_dim="\e[22m"
declare f_reset_underlined="\e[24m"
declare f_reset_blink="\e[25m"
declare f_reset_reverse="\e[27m"
declare f_reset_hidden="\e[28m"

## @fn DisableFormats()
## @param none
## @retval none
## @details Disables all formats at once
function DisableFormats() {
    f_bold=""
    f_dim=""
    f_underlined=""
    f_blink=""
    f_reverse=""
    f_hidden=""

    #reset variables
    f_reset_all=""
    f_reset_bold=""
    f_reset_dim=""
    f_reset_underlined=""
    f_reset_blink=""
    f_reset_reverse=""
    f_reset_hidden="" 
}

fi # BU_FORMATS