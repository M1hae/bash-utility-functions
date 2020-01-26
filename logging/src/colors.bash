if [[ ${BU_COLORS} -ne 1 ]]; then
    BU_COLORS=1
    #Thx to https://misc.flogisoft.com/bash/tip_colors_and_formatting
    # Yeah I know global variables... global variables everywhere! But lets be serious I guess you wanna use them all ;D 
    c_black="\e[30m"
    c_red="\e[31m"
    c_green="\e[32m"
    c_yellow="\e[33m"
    c_blue="\e[34m"
    c_magenta="\e[35m"
    c_cyan="\e[36m"
    c_light_grey="\e[37m"
    c_default="\e[39m"
    c_dark_grey="\e[90m"
    c_light_red="\e[91m"
    c_light_green="\e[92m"
    c_light_yellow="\e[93m"
    c_light_blue="\e[94m"
    c_light_magenta="\e[95m"
    c_light_cyan="\e[96m"
    c_white="\e[97m"

    function DisableColor()
    {
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