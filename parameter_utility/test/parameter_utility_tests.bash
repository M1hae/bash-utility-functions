load ../src/parameter_utility
load ../../testing/test_utilities
load ../../logging/src/logging



help_text_default_output="Info: The following parameters are supported within this script:

Category None:
   -h - Display this help screen (Aliases: --h, --h, --help, -help)"

#
# RegisterParameter tests
#
# @test "GIVEN parameter, WHEN RegisterParameter with parameter, THEN return code 0" {

#     my_parameter="-p"
#     my_helptext="My super helpful text"
#     my_function="echo"

#     run RegisterParameter "${my_parameter}" "${my_function}" "${my_helptext}"

#     AssertStatus 0
# }

# @test "GIVEN parameter, WHEN RegisterParameter with one and two arguments, THEN return code 1" {

#     my_parameter="-p"
#     my_helptext="My super helpful text"
#     my_function="echo"

#     run RegisterParameter "${my_parameter}"
#     AssertStatus 1

#     run RegisterParameter "${my_parameter}" "${my_function}"
#     AssertStatus 1
# }

# @test "GIVEN parameter, WHEN RegisterParameter with five arguments, THEN return code 1" {

#     my_parameter="-p"
#     my_helptext="My super helpful text"
#     my_function="echo"

#     run RegisterParameter "${my_parameter}" "${my_function}" "${my_helptext}" "My category" "Just another random one"
#     AssertStatus 1
# }

# @test "GIVEN help parameter, WHEN RegisterParameter help function, THEN return code 1" {
#     my_parameter="-h"
#     my_helptext="This is my help parameter"
#     my_function="echo"

#     run RegisterParameter "${my_parameter}" "${my_function}" "${my_helptext}"

#     Info "${output}"
#     AssertStatus 1


#     my_parameter="--h"

#     run RegisterParameter "${my_parameter}" "${my_function}" "${my_helptext}"

#     Info "${output}"
#     AssertStatus 1


#     my_parameter="-help"

#     run RegisterParameter "${my_parameter}" "${my_function}" "${my_helptext}"

#     Info "${output}"
#     AssertStatus 1


#     my_parameter="--help"

#     run RegisterParameter "${my_parameter}" "${my_function}" "${my_helptext}"

#     Info "${output}"
#     AssertStatus 1
# }

# @test "GIVEN parameter with no category, WHEN RegisterParameter, THEN category None" {

#     my_parameter="-p"
#     my_helptext="My super helpful text"
#     my_function="echo"

#     RegisterParameter "${my_parameter}" "${my_function}" "${my_helptext}"

#     [[ "None" = ${bu_parameter_cat[1]} ]]
#     AssertStatus 0
# }

# @test "GIVEN parameter with category, WHEN RegisterParameter, THEN right category set" {

#     my_parameter="-p"
#     my_helptext="My super helpful text"
#     my_function="echo"
#     my_category="Blubb"

#     RegisterParameter "${my_parameter}" "${my_function}" "${my_helptext}" ${my_category}

#     [[ "${my_category}" = ${bu_parameter_cat[1]} ]]
#     AssertStatus 0
# }

@test "GIVEN nothing, WHEN ProcessParameters with -h, THEN help text displayed" {

    EnableRawLogging

    run ProcessParameters "-h"

    Info ${output}

    AssertOutput "${help_text_default_output}"
    AssertStatus 0
}

@test "GIVEN parameter, WHEN RegisterParameter and ProcessParameter with -h, THEN help text displayed" {
    EnableRawLogging
    my_parameter="-p"
    my_helptext="My super helpful text"
    my_function="echo"
    my_category="Blubb"
    expected_output=$(echo -e "${help_text_default_output}\n\nCategory Blubb:\n   -p - My super helpful text")

    RegisterParameter "${my_parameter}" "${my_function}" "${my_helptext}" "${my_category}"

    run ProcessParameters "-h"

    AssertOutput "${expected_output}"
    AssertStatus 0
}


#
# test multiple scripts in a row
#
