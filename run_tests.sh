#!/bin/bash
source logging/src/logging.bash

bats='thirdparty/bats/bin/bats'


Info "Logging tests"
${bats} logging/test/logging_tests.bash
