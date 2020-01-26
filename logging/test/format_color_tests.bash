load ../src/logging
load ../src/colors
load ../src/formats
load ../../testing/test_utilities

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
    SetLogLevel "Debug"

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