#!/bin/bash

bashcov -s /usr/bin/bats logging/test/*.bash
bashcov -s /usr/bin/bats filesystem/test/*bash
bashcov -s /usr/bin/bats parameter_utility/test/*.bash
bashcov -s /usr/bin/bats string/test/*.bash