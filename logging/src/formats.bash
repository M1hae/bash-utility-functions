if [[ ! -v BU_FORMATS ]]; then
    BU_FORMATS=1

    #Thx to https://misc.flogisoft.com/bash/tip_colors_and_formatting
    # Yeah I know global variables... global variables everywhere! But lets be serious I guess you wanna use them all ;D 
    f_bold="\e[1m"
    f_dim="\e[2m"
    #todo \e[3m ?!?
    f_underlined="\e[4m"
    f_blink="\e[5m"
    f_reverse="\e[7m"
    #todo \e[6m ?!?
    f_hidden="\e[8m"

    #reset variables
    f_reset_all="\e[0m"
    f_reset_bold="\e[21m"
    f_reset_dim="\e[22m"
    f_reset_underlined="\e[24m"
    f_reset_blink="\e[25m"
    f_reset_reverse="\e[27m"
    f_reset_hidden="\e[28m"

    function DisableFormats()
    {
        f_bold=""
        f_dim=""
        #todo \e[3m ?!?
        f_underlined=""
        f_blink=""
        f_reverse=""
        #todo \e[6m ?!?
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