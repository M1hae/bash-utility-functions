load ../src/filesystem
load ../../testing/test_utilities
load ../../logging/src/logging


test_folder_structure_deep="my/test/is/cool/stuff"
test_folder_strucutre_medium="my/test/is"
test_folder_structure_short="my/dmn"

empty_file="${test_folder_strucutre_medium}/empty"
log_file="${test_folder_strucutre_medium}/test.log"
symbolic_link_to_folder="${test_folder_structure_short}/sym_link_dir"
symbolic_link_to_file="${test_folder_structure_short}/sym_link_file"
not_existing_file="${test_folder_structure_deep}/not_existing.log"
not_existing_directory="${test_folder_strucutre_medium}/not_existing"

setup()
{
    Info "Setup test folder with directories and files"
    mkdir -p ${test_folder_structure_deep}
    mkdir -p ${test_folder_strucutre_medium}
    mkdir -p ${test_folder_structure_short}
    touch ${empty_file}
    echo "12:03 Start system" > ${log_file}
    echo "12:04 Prepare unicorns" >> ${log_file}
    echo "12:05 Arrange tables" >> ${log_file}
    echo "12:06 Embrase teddy" >> ${log_file}
    echo "12:07 System ready to use" >> ${log_file}
    ln -s ${test_folder_structure_deep} ${symbolic_link_to_folder}
    ln -s ${log_file} ${symbolic_link_to_file}

    Info "Folder structure of my"
    ls -Rll my
}

teardown()
{
    Info "Delete test folder"
    rm -rf my
}

#
# IsFile tests
#
@test "GIVEN log file, WHEN executing IsFile, THEN return code 0" {
    run IsFile ${log_file}

    AssertStatus 0
}

@test "GIVEN not existing log file, WHEN executing IsFile, THEN return code 1" {
    run IsFile ${not_existing_file}

    AssertStatus 1
}

@test "GIVEN directory, WHEN executing IsFile, THEN return code 1" {
    run IsFile ${test_folder_structure_short}

    AssertStatus 1
}

@test "GIVEN symbolic link to file, WHEN executing IsFile, THEN return code 1" {
    run IsFile ${symbolic_link_to_file}

    AssertStatus 1
}

@test "GIVEN symbolic link to directory, WHEN executing IsFile, THEN return code 1" {
    run IsFile ${symbolic_link_to_directory}

    AssertStatus 1
}

#
# IsDirectory
#
@test "GIVEN directory, WHEN executing IsDirectory, THEN return code 0" {
    run IsDirectory ${test_folder_strucutre_medium}

    AssertStatus 0
}

@test "GIVEN not existing directory, WHEN executing IsDirectory, THEN return code 1" {
    run IsDirectory ${not_existing_directory}

    AssertStatus 1
}

@test "GIVEN existing file, WHEN executing IsDirectory, THEN return code 1" {
    run IsDirectory ${log_file}

    AssertStatus 1
}

@test "GIVEN symbolic link to file, WHEN executing IsDirectory, THEN return code 1" {
    run IsDirectory ${symbolic_link_to_file}

    AssertStatus 1
}

@test "GIVEN symbolic link to directory, WHEN executing IsDirectory, THEN return code 1" {
    run IsDirectory ${symbolic_link_to_directory}

    AssertStatus 1
}

#
# AssertIsFile tests
#
@test "GIVEN existing file, WHEN executing AssertIsFile, THEN return code 0" {
    run AssertIsFile ${log_file}

    AssertStatus 0
}

@test "GIVEN not existing file, WHEN executing AssertIsFile, THEN fatal output with return code 1" {
    EnableRawLogging
    expected_output="Fatal: File ${not_existing_file} does not exist"

    run AssertIsFile ${not_existing_file}

    AssertStatus 1
    AssertOutput "${expected_output}"
}

@test "GIVEN existing file and debug enabled, WHEN executing AssertIsFile, THEN debug output with return code 0" {
    SetLogLevel "Debug"
    EnableRawLogging
    expected_output="Debug: File ${log_file} exists"

    run AssertIsFile ${log_file}

    AssertStatus 0
    AssertOutput "${expected_output}"
}
