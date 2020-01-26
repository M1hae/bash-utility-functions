load ../src/logging
load ../src/colors
load ../src/formats
load ../../testing/test_utilities

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
    SetLogLevel "Debug"

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