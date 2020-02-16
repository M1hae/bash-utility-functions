#!/bin/bash
set -eu

source logging/src/logging.bash
source filesystem/src/filesystem.bash
source parameter_utility/src/parameter_utility.bash

bats='thirdparty/bats/bin/bats'

function ExecuteTest()
{
    AssertIsFile ${bats}
    AssertIsExecutable ${bats}

    Info "Executing ${1}:"
    ${bats} ${1}
    return $?
}

ExecuteTest "logging/test/single_argument_tests.bash"
ExecuteTest "logging/test/format_color_tests.bash"
ExecuteTest "logging/test/multiple_arguments_tests.bash"
ExecuteTest "logging/test/die_tests.bash"
ExecuteTest "logging/test/log_level_tests.bash"
ExecuteTest "string/test/string_tests.bash"
ExecuteTest "filesystem/test/filesystem_tests.bash"
ExecuteTest "parameter_utility/test/parameter_utility_tests.bash"
