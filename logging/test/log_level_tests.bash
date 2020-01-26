load ../src/logging
load ../src/colors
load ../src/formats
load ../../testing/test_utilities

@test "GIVE output string and log level Crap, WHEN executing Info, THEN log level not supported" {
    test_string="This is a major f*ck up"
    log_level="Crap"

    expected_string=$(echo -e "${f_blink}${c_red}Fatal: ${f_reset_all}Not supported log level provided: ${log_level}")

    run SetLogLevel "${log_level}"
 
    AssertStatus 1
    AssertOutput "${expected_string}"
}

@test "GIVE output string and log level Info, WHEN executing Info, THEN info output" {
    test_string="Output string"
    log_level="Info"

    expected_string=$(echo -e "${c_green}Info: ${f_reset_all}${test_string}")

    run SetLogLevel "${log_level}"
    run Info "${test_string}"
 
    AssertStatus 0
    AssertOutput "${expected_string}"
}