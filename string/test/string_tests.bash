load ../src/string
load ../../testing/test_utilities

#
# ToLowerCase tests
#
@test "GIVEN lower case string, WHEN executing ToLowerCase, THEN same string returned" {
    test_string="teststring"
    expected_string=${test_string}

    run ToLowerCase "${test_string}" 

    AssertStatus 0
    AssertOutput "${expected_string}"
}

@test "GIVEN lower uppercase mix string, WHEN executing ToLowerCase, THEN lowercase string returned" {
    test_string="TeStsTriNg"
    expected_string="teststring"

    run ToLowerCase "${test_string}" 

    AssertStatus 0
    AssertOutput "${expected_string}"
}

@test "GIVEN string with numbers and special characters, WHEN executing ToLowerCase, THEN alphabetic characters returned in lowercase" {
    test_string="T@StsTr1Ng%"
    expected_string="t@ststr1ng%"

    run ToLowerCase "${test_string}" 

    AssertStatus 0
    AssertOutput "${expected_string}"
}

@test "GIVEN most characters, WHEN executing ToLowerCase, THEN alphabetic characters returned in lowercase" {
    test_string="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZÖÄÜ!\"§$%&/()=ß?{[]}\,.-;:_#'*+~+><|^°"
    expected_string="0123456789abcdefghijklmnopqrstuvwxyzöäü!\"§$%&/()=ß?{[]}\,.-;:_#'*+~+><|^°"

    run ToLowerCase "${test_string}" 

    AssertStatus 0
    AssertOutput "${expected_string}"
}

@test "GIVEN multiple strings, WHEN executing ToLowerCase, THEN only first one is processed" {
    test_string1="TEST"
    test_string2="STRING"
    expected_string="test"

    run ToLowerCase "${test_string1}" "${test_string2}" 

    AssertStatus 0
    AssertOutput "${expected_string}"
}

#
# ToUpperCase tests
#
@test "GIVEN upper case string, WHEN executing ToUpperCase, THEN same string returned" {
    test_string="TESTSTRING"
    expected_string=${test_string}

    run ToUpperCase "${test_string}" 

    AssertStatus 0
    AssertOutput "${expected_string}"
}

@test "GIVEN lower uppercase mix string, WHEN executing ToUpperCase, THEN uppercase string returned" {
    test_string="TeStsTriNg"
    expected_string="TESTSTRING"

    run ToUpperCase "${test_string}" 

    AssertStatus 0
    AssertOutput "${expected_string}"
}

@test "GIVEN string with numbers and special characters, WHEN executing ToUpperCase, THEN alphabetic characters returned in uppercase" {
    test_string="T@StsTr1Ng%"
    expected_string="T@STSTR1NG%"

    run ToUpperCase "${test_string}" 

    AssertStatus 0
    AssertOutput "${expected_string}"
}

@test "GIVEN most characters, WHEN executing ToUpperCase, THEN alphabetic characters returned in uppercase" {
    test_string="0123456789abcdefghijklmnopqrstuvwxyzöäü!\"§$%&/()=ß?{[]}\,.-;:_#'*+~+><|^°"
    expected_string="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZÖÄÜ!\"§$%&/()=ß?{[]}\,.-;:_#'*+~+><|^°"

    run ToUpperCase "${test_string}" 

    AssertStatus 0
    AssertOutput "${expected_string}"
}

@test "GIVEN multiple strings, WHEN executing ToUpperCase, THEN only first one is processed" {
    test_string1="test"
    test_string2="string"
    expected_string="TEST"

    run ToUpperCase "${test_string1}" "${test_string2}" 

    AssertStatus 0
    AssertOutput "${expected_string}"
}

#
# String length tests
#
@test "GIVEN empty string, WHEN executing StringLength, THEN zero returned" {
    test_string=""
    expected_length=0

    string_length=$(StringLength "${test_string}")

    [[ ${expected_length} -eq ${string_length} ]]
}

@test "GIVEN random string, WHEN executing StringLength, THEN correct size returned" {
    test_string="asdf#1337!"
    expected_length=10

    string_length=$(StringLength "${test_string}")

    [[ ${expected_length} -eq ${string_length} ]]
}

#
# Remove at tests
#
@test "GIVEN empty string and index 1, WHEN executing RemoveAt, THEN return" {
    test_string=""
    string_index=1

    run RemoveAt "${test_string}" ${string_index}

    AssertStatus 0
    AssertOutput "${test_string}"
}

@test "GIVEN random string and index 3, WHEN executing RemoveAt, THEN character at index 3 removed" {
    test_string="asdfTest"
    string_index=3
    expect_string="asdTest"

    run RemoveAt "${test_string}" ${string_index}

    AssertStatus 0
    AssertOutput "${expect_string}"
}

@test "GIVEN random string and index negative, WHEN executing RemoveAt, THEN input string returned" {
    test_string="asdfTest"
    string_index=-1
    expect_string="asdfTest"

    run RemoveAt "${test_string}" ${string_index}

    AssertStatus 0
    AssertOutput "${expect_string}"
}

@test "GIVEN random string and index out of range, WHEN executing RemoveAt, THEN input string returned" {
    test_string="asdfTest"
    string_index=20
    expect_string="asdfTest"

    run RemoveAt "${test_string}" ${string_index}

    AssertStatus 0
    AssertOutput "${expect_string}"
}

#
# Remove last tests
#
@test "GIVEN empty string, WHEN executing RemoveLast, THEN return empty string" {
    test_string=""
    expect_string=""

    run RemoveLast "${test_string}" 

    AssertStatus 0
    AssertOutput "${expect_string}"
}

@test "GIVEN random string, WHEN executing RemoveLast, THEN last character removed" {
    test_string="asdfTest"
    expect_string="asdfTes"

    run RemoveLast "${test_string}" 

    AssertStatus 0
    AssertOutput "${expect_string}"
}

#
# Remove last tests
#
@test "GIVEN empty string, WHEN executing RemoveFirst, THEN return empty string" {
    test_string=""
    expect_string=""

    run RemoveFirst "${test_string}" 

    AssertStatus 0
    AssertOutput "${expect_string}"
}

@test "GIVEN random string, WHEN executing RemoveFirst, THEN first character removed" {
    test_string="asdfTest"
    expect_string="sdfTest"

    run RemoveFirst "${test_string}" 

    AssertStatus 0
    AssertOutput "${expect_string}"
}

#
# SplitAtReturnFirst tests
#
@test "GIVEN empty string and index 5, WHEN executing SplitAtReturnFirst, THEN empty string returned" {
    test_string=""
    string_index=5
    expect_string=""

    run SplitAtReturnFirst "${test_string}" ${string_index}

    AssertStatus 0
    AssertOutput "${expect_string}"
}

@test "GIVEN random string and index 4, WHEN executing SplitAtReturnFirst, THEN first sequence returned" {
    test_string="asdgjl12l3kjl1jl"
    string_index=4
    expect_string="asdg"

    run SplitAtReturnFirst "${test_string}" ${string_index}

    AssertStatus 0
    AssertOutput "${expect_string}"
}

@test "GIVEN random string and negative index, WHEN executing SplitAtReturnFirst, THEN empty string returned" {
    test_string="asdgjl12l3kjl1jl"
    string_index=-1
    expect_string=""

    run SplitAtReturnFirst "${test_string}" ${string_index}

    AssertStatus 0
    AssertOutput "${expect_string}"
}

@test "GIVEN random string and index out of range, WHEN executing SplitAtReturnFirst, THEN input string returned" {
    test_string="asdgjl12l3kjl1jl"
    string_index=16
    expect_string="${test_string}"

    run SplitAtReturnFirst "${test_string}" ${string_index}

    AssertStatus 0
    AssertOutput "${expect_string}"
}

#
# SplitAtReturnLast tests
#
@test "GIVEN empty string and index 5, WHEN executing SplitAtReturnLast, THEN empty string returned" {
    test_string=""
    string_index=5
    expect_string=""

    run SplitAtReturnLast "${test_string}" ${string_index}

    AssertStatus 0
    AssertOutput "${expect_string}"
}

@test "GIVEN random string and index 4, WHEN executing SplitAtReturnLast, THEN first sequence returned" {
    test_string="asdgjl12l3kjl1jl"
    string_index=4
    expect_string="jl12l3kjl1jl"

    run SplitAtReturnLast "${test_string}" ${string_index}

    AssertStatus 0
    AssertOutput "${expect_string}"
}

@test "GIVEN random string and negative index, WHEN executing SplitAtReturnLast, THEN input string returned" {
    test_string="asdgjl12l3kjl1jl"
    string_index=-1
    expect_string="${test_string}"

    run SplitAtReturnLast "${test_string}" ${string_index}

    AssertStatus 0
    AssertOutput "${expect_string}"
}

@test "GIVEN random string and index out of range, WHEN executing SplitAtReturnLast, THEN empty string returned" {
    test_string="asdgjl12l3kjl1jl"
    string_index=16
    expect_string=""

    run SplitAtReturnLast "${test_string}" ${string_index}

    AssertStatus 0
    AssertOutput "${expect_string}"
}