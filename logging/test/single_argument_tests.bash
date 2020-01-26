load ../src/logging
load ../src/colors
load ../src/formats
load ../../testing/test_utilities

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
    SetLogLevel "Debug"

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