load ../src/logging
load ../src/colors
load ../src/formats
load ../../testing/test_utilities

#
# Wrong log level provided
#
@test "GIVEN output string and log level Crap, WHEN executing Info, THEN log level not supported" {
    log_level="Crap"
    expected_string=$(echo -e "${f_blink}${c_red}Fatal: ${f_reset_all}Not supported log level provided: ${log_level}")
    run SetLogLevel "${log_level}"
 
    AssertStatus 1
    AssertOutput "${expected_string}"
}

#
# Log level Info
#
@test "GIVEN output string and log level Info, WHEN executing Debug, THEN no output" {
    test_string="Output string"
    log_level="Info"
    expected_string=""
    SetLogLevel "${log_level}"

    run Debug "${test_string}"
 
    AssertStatus 0
    AssertOutput "${expected_string}"
}

@test "GIVEN output string and log level Info, WHEN executing Info, THEN Info output" {
    test_string="Output string"
    log_level="Info"
    expected_string=$(echo -e "${c_green}Info: ${f_reset_all}${test_string}")
    SetLogLevel "${log_level}"

    run Info "${test_string}"
 
    AssertStatus 0
    AssertOutput "${expected_string}"
}

@test "GIVEN output string and log level Info, WHEN executing Warning, THEN Warning output" {
    test_string="Output string"
    log_level="Info"
    expected_string=$(echo -e "${c_red}Warning: ${f_reset_all}${test_string}")
    SetLogLevel "${log_level}"

    run Warning "${test_string}"
 
    AssertStatus 0
    AssertOutput "${expected_string}"
}

@test "GIVEN output string and log level Info, WHEN executing Fatal, THEN Fatal output" {
    test_string="Output string"
    log_level="Info"
    expected_string=$(echo -e "${f_blink}${c_red}Fatal: ${f_reset_all}${test_string}")
    SetLogLevel "${log_level}"

    run Fatal "${test_string}"
 
    AssertStatus 0
    AssertOutput "${expected_string}"
}

#
# Log level Debug
#
@test "GIVEN output string and log level Debug, WHEN executing Debug, THEN Debug output" {
    test_string="Output string"
    log_level="Debug"
    expected_string=$(echo -e "${c_yellow}Debug: ${f_reset_all}${test_string}")
    SetLogLevel "${log_level}"

    run Debug "${test_string}"
 
    AssertStatus 0
    AssertOutput "${expected_string}"
}

@test "GIVEN output string and log level Debug, WHEN executing Info, THEN Info output" {
    test_string="Output string"
    log_level="Debug"
    expected_string=$(echo -e "${c_green}Info: ${f_reset_all}${test_string}")
    SetLogLevel "${log_level}"

    run Info "${test_string}"
 
    AssertStatus 0
    AssertOutput "${expected_string}"
}

@test "GIVEN output string and log level Debug, WHEN executing Warning, THEN Warning output" {
    test_string="Output string"
    log_level="Debug"
    expected_string=$(echo -e "${c_red}Warning: ${f_reset_all}${test_string}")
    SetLogLevel "${log_level}"
    
    run Warning "${test_string}"
 
    AssertStatus 0
    AssertOutput "${expected_string}"
}

@test "GIVEN output string and log level Debug, WHEN executing Fatal, THEN Fatal output" {
    test_string="Output string"
    log_level="Debug"
    expected_string=$(echo -e "${f_blink}${c_red}Fatal: ${f_reset_all}${test_string}")
    SetLogLevel "${log_level}"
    
    run Fatal "${test_string}"
 
    AssertStatus 0
    AssertOutput "${expected_string}"
}

#
# Log level Warning
#
@test "GIVEN output string and log level Warning, WHEN executing Debug, THEN no output" {
    test_string="Output string"
    log_level="Warning"
    expected_string=""
    SetLogLevel "${log_level}"
    
    run Debug "${test_string}"
 
    AssertStatus 0
    AssertOutput "${expected_string}"
}

@test "GIVEN output string and log level Warning, WHEN executing Info, THEN no output" {
    test_string="Output string"
    log_level="Warning"
    expected_string=""
    SetLogLevel "${log_level}"
    
    run Info "${test_string}"
 
    AssertStatus 0
    AssertOutput "${expected_string}"
}

@test "GIVEN output string and log level Warning, WHEN executing Warning, THEN Warning output" {
    test_string="Output string"
    log_level="Warning"
    expected_string=$(echo -e "${c_red}Warning: ${f_reset_all}${test_string}")
    SetLogLevel "${log_level}"
    
    run Warning "${test_string}"
 
    AssertStatus 0
    AssertOutput "${expected_string}"
}

@test "GIVEN output string and log level Warning, WHEN executing Fatal, THEN Fatal output" {
    test_string="Output string"
    log_level="Warning"
    expected_string=$(echo -e "${f_blink}${c_red}Fatal: ${f_reset_all}${test_string}")
    SetLogLevel "${log_level}"
    
    run Fatal "${test_string}"
 
    AssertStatus 0
    AssertOutput "${expected_string}"
}

#
# Log level Fatal
#
@test "GIVEN output string and log level Fatal, WHEN executing Debug, THEN no output" {
    test_string="Output string"
    log_level="Fatal"
    expected_string=""
    SetLogLevel "${log_level}"
    
    run Debug "${test_string}"
 
    AssertStatus 0
    AssertOutput "${expected_string}"
}

@test "GIVEN output string and log level Fatal, WHEN executing Info, THEN no output" {
    test_string="Output string"
    log_level="Fatal"
    expected_string=""
    SetLogLevel "${log_level}"
    
    run Info "${test_string}"
 
    AssertStatus 0
    AssertOutput "${expected_string}"
}

@test "GIVEN output string and log level Fatal, WHEN executing Warning, THEN no output" {
    test_string="Output string"
    log_level="Fatal"
    expected_string=""
    SetLogLevel "${log_level}"
    
    run Warning "${test_string}"
 
    AssertStatus 0
    AssertOutput "${expected_string}"
}

@test "GIVEN output string and log level Fatal, WHEN executing Fatal, THEN Fatal output" {
    test_string="Output string"
    log_level="Fatal"
    expected_string=$(echo -e "${f_blink}${c_red}Fatal: ${f_reset_all}${test_string}")
    SetLogLevel "${log_level}"
    
    run Fatal "${test_string}"
 
    AssertStatus 0
    AssertOutput "${expected_string}"
}

#
# Log level Disabled
#
@test "GIVEN output string and log level Disabled, WHEN executing Debug, THEN no output" {
    test_string="Output string"
    log_level="Disabled"
    expected_string=""
    SetLogLevel "${log_level}"
    
    run Debug "${test_string}"
 
    AssertStatus 0
    AssertOutput "${expected_string}"
}

@test "GIVEN output string and log level Disabled, WHEN executing Info, THEN no output" {
    test_string="Output string"
    log_level="Disabled"
    expected_string=""
    SetLogLevel "${log_level}"
    
    run Info "${test_string}"
 
    AssertStatus 0
    AssertOutput "${expected_string}"
}

@test "GIVEN output string and log level Disabled, WHEN executing Warning, THEN no output" {
    test_string="Output string"
    log_level="Disabled"
    expected_string=""
    SetLogLevel "${log_level}"
    
    run Warning "${test_string}"
 
    AssertStatus 0
    AssertOutput "${expected_string}"
}

@test "GIVEN output string and log level Disabled, WHEN executing Fatal, THEN no output" {
    test_string="Output string"
    log_level="Disabled"
    expected_string=""
    SetLogLevel "${log_level}"
    
    run Fatal "${test_string}"
 
    AssertStatus 0
    AssertOutput "${expected_string}"
}