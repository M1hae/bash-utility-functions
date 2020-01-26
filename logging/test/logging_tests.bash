load ../src/logging
load ../src/colors
load ../src/formats
load ../../testing/test_utilities

#
# Single argument tests for every logging function
#
@test "GIVEN input text, WHEN executing Info, THEN output message correctly formated" {
    test_string="My Fancy text"
    expected_string=$(echo -e "${c_green}Info: ${f_reset_all}${test_string}")

    run Info "${test_string}"

    AssertStatus 0
    AssertOutput "${expected_string}"
}

@test "GIVEN input text, WHEN executing Debug, THEN output message correctly formated" {
    test_string="My Fancy text"
    expected_string=$(echo -e "${c_yellow}Debug: ${f_reset_all}${test_string}")

    run Debug "${test_string}"

    AssertStatus 0
    AssertOutput "${expected_string}"
}

@test "GIVEN input text, WHEN executing Warning, THEN output message correctly formated" {
    test_string="My Fancy text"
    expected_string=$(echo -e "${c_red}Warning: ${f_reset_all}${test_string}")

    run Warning "${test_string}"

    AssertStatus 0
    AssertOutput "${expected_string}"
}

@test "GIVEN input text, WHEN executing Fatal, THEN output message correctly formated" {
    test_string="My Fancy text"
    expected_string=$(echo -e "${f_blink}${c_red}Fatal: ${f_reset_all}${test_string}")

    run Fatal "${test_string}"

    AssertStatus 0
    AssertOutput "${expected_string}"
}

#
# Multiple argument tests for every logging function
#
@test "GIVEN multiple input texts, WHEN executing Info, THEN output message correctly formated and complete" {
    test_string="My Fancy text"
    test_string2="taaatttüüüü"
    expected_string=$(echo -e "${c_green}Info: ${f_reset_all}${test_string} ${test_string2}")

    run Info "${test_string}" "${test_string2}"

    AssertStatus 0
    AssertOutput "${expected_string}"
}

@test "GIVEN multiple input texts, WHEN executing Debug, THEN output message correctly formated and complete" {
    test_string="My Fancy text"
    test_string2="taaatttüüüü"
    expected_string=$(echo -e "${c_yellow}Debug: ${f_reset_all}${test_string} ${test_string2}")

    run Debug "${test_string}" "${test_string2}"

    AssertStatus 0
    AssertOutput "${expected_string}"
}

@test "GIVEN multiple input texts, WHEN executing Warning, THEN output message correctly formated and complete" {
    test_string="My Fancy text"
    test_string2="taaatttüüüü"
    expected_string=$(echo -e "${c_red}Warning: ${f_reset_all}${test_string} ${test_string2}")

    run Warning "${test_string}" "${test_string2}"

    AssertStatus 0
    AssertOutput "${expected_string}"
}

@test "GIVEN multiple input texts, WHEN executing Fatal, THEN output message correctly formated and complete" {
    test_string="My Fancy text"
    test_string2="taaatttüüüü"
    expected_string=$(echo -e "${f_blink}${c_red}Fatal: ${f_reset_all}${test_string} ${test_string2}")

    run Fatal "${test_string}" "${test_string2}"

    AssertStatus 0
    AssertOutput "${expected_string}"
}

#
# Format and color disabled test
#
@test "GIVEN input texts, WHEN executing Info, THEN output message correctly formated and complete" {
    test_string="My Fancy text"
    expected_string="Info: ${test_string}"

    EnableRawLogging

    run Info "${test_string}"

    AssertStatus 0
    AssertOutput "${expected_string}"
}

@test "GIVEN input texts, WHEN executing Debug, THEN output message correctly formated and complete" {
    test_string="My Fancy text"
    expected_string="Debug: ${test_string}"

    EnableRawLogging

    run Debug "${test_string}"

    AssertStatus 0
    AssertOutput "${expected_string}"
}

@test "GIVEN input texts, WHEN executing Warning, THEN output message correctly formated and complete" {
    test_string="My Fancy text"
    expected_string="Warning: ${test_string}"

    EnableRawLogging

    run Warning "${test_string}"

    AssertStatus 0
    AssertOutput "${expected_string}"
}

@test "GIVEN input texts, WHEN executing Fatal, THEN output message correctly formated and complete" {
    test_string="My Fancy text"
    expected_string="Fatal: ${test_string}"

    EnableRawLogging

    run Fatal "${test_string}"

    AssertStatus 0
    AssertOutput "${expected_string}"
}

#
# Penetrate die function
#
@test "GIVEN error message and no return code, WHEN executing Die, THEN Over and out with right message and return code 1" {
    test_string="This is a major f*ck up"
    expected_string=$(echo -e "${f_blink}${c_red}Fatal: ${f_reset_all}${test_string}")

    run Die "${test_string}"

    AssertStatus 1
    AssertOutput "${expected_string}"
}

@test "GIVEN error message and return code, WHEN executing Die, THEN Over and out with right message and correct return code" {
    test_string="This is a major f*ck up"
    return_code=42
    expected_string=$(echo -e "${f_blink}${c_red}Fatal: ${f_reset_all}${test_string}")

    run Die "${test_string}" ${return_code}

    AssertStatus ${return_code}
    AssertOutput "${expected_string}"
}

@test "GIVEN multiple message and return code, WHEN executing Die, THEN Fatal message displayed" {
    test_string="This is a major f*ck up"
    test_string2="REALLY!"
    return_code=42
    expected_string=$(echo -e "${f_blink}${c_red}Fatal: ${f_reset_all}${test_string} ${test_string2}")

    run Die "${test_string}" "${test_string2}" ${return_code}

    AssertStatus 1
}

@test "GIVE output string and log level Crap, WHEN executing Info, THEN log level not supported" {
    test_string="This is a major f*ck up"
    log_level="Crap"

    expected_string=$(echo -e "${f_blink}${c_red}Fatal: ${f_reset_all}Not supported log level provided")

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