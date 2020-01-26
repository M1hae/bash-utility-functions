load ../src/logging
load ../src/colors
load ../src/formats
load ../../testing/test_utilities


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