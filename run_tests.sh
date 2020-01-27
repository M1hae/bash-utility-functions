#!/bin/bash
set -eu

source logging/src/logging.bash

bats='thirdparty/bats/bin/bats'

Info "Single argument tests"
${bats} logging/test/single_argument_tests.bash

Info "Multiple argument tests"
${bats} logging/test/multiple_arguments_tests.bash

Info "Format and color tests"
${bats} logging/test/format_color_tests.bash

Info "Die function tests"
${bats} logging/test/die_tests.bash

Info "Log level tests"
${bats} logging/test/log_level_tests.bash


