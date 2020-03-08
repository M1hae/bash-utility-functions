load ../src/parameter_utility
load ../../testing/test_utilities
load ../../logging/src/logging


help_text_default_output="Info: The following parameters are supported within this script:

Category None:
   -h - Display this help screen (Aliases: --h, --h, --help, -help)"

function MyFancyTestFunction()
{
   my_temp_test_string="a massive string"
   my_temp_test_num=42
}

function MyFunctionNeedsAnARG()
{
    echo "$1"
}

#
# RegisterParameter tests
#
@test "GIVEN parameter, WHEN RegisterParameter with parameter, THEN return code 0" {
    my_parameter="-p"
    my_helptext="My super helpful text"
    my_function="echo"

    run RegisterParameter "${my_parameter}" "${my_function}" "${my_helptext}"

    AssertStatus 0
}

@test "GIVEN parameter, WHEN RegisterParameter with one and two arguments, THEN return code 1" {
    my_parameter="-p"
    my_helptext="My super helpful text"
    my_function="echo"

    run RegisterParameter "${my_parameter}"
    AssertStatus 1

    run RegisterParameter "${my_parameter}" "${my_function}"
    AssertStatus 1
}

@test "GIVEN parameter, WHEN RegisterParameter with five arguments, THEN return code 1" {
    my_parameter="-p"
    my_helptext="My super helpful text"
    my_function="echo"

    run RegisterParameter "${my_parameter}" "${my_function}" "${my_helptext}" "My category" "Just another random one"
    AssertStatus 1
}

@test "GIVEN help parameter, WHEN RegisterParameter help function, THEN return code 1" {
    my_parameter="-h"
    my_helptext="This is my help parameter"
    my_function="echo"

    run RegisterParameter "${my_parameter}" "${my_function}" "${my_helptext}"

    Info "${output}"
    AssertStatus 1

    my_parameter="--h"

    run RegisterParameter "${my_parameter}" "${my_function}" "${my_helptext}"

    Info "${output}"
    AssertStatus 1

    my_parameter="-help"

    run RegisterParameter "${my_parameter}" "${my_function}" "${my_helptext}"

    Info "${output}"
    AssertStatus 1

    my_parameter="--help"

    run RegisterParameter "${my_parameter}" "${my_function}" "${my_helptext}"

    Info "${output}"
    AssertStatus 1
}

@test "GIVEN parameter with no category, WHEN RegisterParameter, THEN category None" {
    my_parameter="-p"
    my_helptext="My super helpful text"
    my_function="echo"

    RegisterParameter "${my_parameter}" "${my_function}" "${my_helptext}"

    [[ "None" = ${bu_parameter_cat[1]} ]]
    AssertStatus 0
}

@test "GIVEN parameter with category, WHEN RegisterParameter, THEN right category set" {
    my_parameter="-p"
    my_helptext="My super helpful text"
    my_function="echo"
    my_category="Blubb"

    RegisterParameter "${my_parameter}" "${my_function}" "${my_helptext}" ${my_category}

    [[ "${my_category}" = ${bu_parameter_cat[1]} ]]
    AssertStatus 0
}

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

@test "GIVEN not registered parameter, WHEN ProcessParameter, THEN terminate" {
   EnableRawLogging
   my_parameter="-o"
   expected_output="Fatal: Could not find ${my_parameter}! You need to register it first with RegisterParameter"

   run ProcessParameters "${my_parameter}"

   Info "${output}"
   
   AssertOutput "${expected_output}"
   AssertStatus 1
}

@test "GIVEN parameter with bash function, WHEN ProcessParameter, THEN variables set to defined ones" {
   EnableRawLogging
   my_parameter="-p"
   my_helptext="Set my_temp_test_string=\"a massive string\" and my_temp_test_num=42"
   my_function="MyFancyTestFunction"

   RegisterParameter "${my_parameter}" "${my_function}" "${my_helptext}"

   ProcessParameters "${my_parameter}"
   
   AssertStatus 0
   [[ "${my_temp_test_string}" = "a massive string" ]]
   [[ ${my_temp_test_num} -eq 42 ]]
}

@test "GIVEN parameter with bash command, WHEN ProcessParameter with argument, THEN command output is the correct one" {
   EnableRawLogging
   my_parameter="-e"
   my_helptext="This parameter is a wrapper for echo"
   my_function="echo"
   my_function_argument="My function argument"
   expected_output="${my_function_argument}"

   RegisterParameter "${my_parameter}" "${my_function}" "${my_helptext}"

   run ProcessParameters "${my_parameter}" "${my_function_argument}"
   
   AssertStatus 0
   AssertOutput "${expected_output}"
}

@test "GIVEN parameter with bash function, WHEN ProcessParameter with argument, THEN bash function is called with all providede parameters" {
   EnableRawLogging
   my_parameter="-e"
   my_helptext="This parameter is a wrapper for echo"
   my_function="MyFunctionNeedsAnARG"
   my_function_argument="This is my fancy argument"
   expected_output="${my_function_argument}"

   RegisterParameter "${my_parameter}" "${my_function}" "${my_helptext}"

   run ProcessParameters "${my_parameter}" "${my_function_argument}"
   
   AssertStatus 0
   AssertOutput "${expected_output}"
}

@test "GIVEN random argument, WHEN calling DisplayHelpMessages, THEN die with message" {
   EnableRawLogging
   expected_output="Fatal: DisplayHelpMessages called with parameters! This is not supported!"
   run DisplayHelpMessages "random"
   
   AssertStatus 1
   AssertOutput "${expected_output}"
}
