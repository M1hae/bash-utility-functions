#!/bin/bash
set -eu

source logging/src/logging.bash

bats='thirdparty/bats/bin/bats'

function ExecuteTest()
{
    Info "Executing ${1}:"
    ${bats} ${1}
}

ExecuteTest "logging/test/single_argument_tests.bash"
ExecuteTest "logging/test/multiple_arguments_tests.bash"
ExecuteTest "logging/test/format_color_tests.bash"
ExecuteTest "logging/test/die_tests.bash"
ExecuteTest "logging/test/log_level_tests.bash"
ExecuteTest "string/test/string_tests.bash"
