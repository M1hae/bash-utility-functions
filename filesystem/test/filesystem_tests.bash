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
not_existing_symbolic_link="${test_folder_strucutre_medium}/not_existing_sym_link"
not_readable_file="${test_folder_strucutre_medium}/not_readable_file"
not_writeable_file="${test_folder_strucutre_medium}/not_writeable_file"
not_executable_file="${test_folder_strucutre_medium}/not_executable_file"

setup()
{
    Info "Setup test folder with directories and files"
    mkdir -p ${test_folder_structure_deep}
    mkdir -p ${test_folder_strucutre_medium}
    mkdir -p ${test_folder_structure_short}
    touch ${empty_file}
    touch ${not_readable_file}
    chmod 300 ${not_readable_file}

    touch ${not_writeable_file}
    chmod 500 ${not_writeable_file}

    touch ${not_executable_file}
    chmod 600 ${not_executable_file}

    echo "12:03 Start system" > ${log_file}
    echo "12:04 Prepare unicorns" >> ${log_file}
    echo "12:05 Arrange tables" >> ${log_file}
    echo "12:06 Embrase teddy" >> ${log_file}
    echo "12:07 System ready to use" >> ${log_file}
    chmod 700 ${log_file}
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
    run IsFile ${symbolic_link_to_folder}

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
    run IsDirectory ${symbolic_link_to_folder}

    AssertStatus 1
}

#
# IsSymbolicLink
#
@test "GIVEN exisiting symbolic link, WHEN executing IsSymbolicLink, THEN return code 0" {
    run IsSymbolicLink ${symbolic_link_to_folder}

    AssertStatus 0
}

@test "GIVEN not exisiting symbolic_link, WHEN executing IsSymbolicLink, THEN return code 1" {
    run IsSymbolicLink ${not_existing_symbolic_link}

    AssertStatus 1
}


#
# IsExisting
#
@test "GIVEN exisiting file, WHEN executing IsExisting, THEN return code 0" {
    run IsExisting ${log_file}

    AssertStatus 0
}

@test "GIVEN exisiting directory, WHEN executing IsExisting, THEN return code 0" {
    run IsExisting ${test_folder_structure_short}

    AssertStatus 0
}

@test "GIVEN exisiting symbolic link, WHEN executing IsExisting, THEN return code 0" {
    run IsExisting ${symbolic_link_to_folder}

    AssertStatus 0
}

@test "GIVEN not exisiting file, WHEN executing IsExisting, THEN return code 1" {
    run IsExisting ${not_existing_file}

    AssertStatus 1
}

@test "GIVEN not exisiting directory, WHEN executing IsExisting, THEN return code 1" {
    run IsExisting ${not_existing_folder}

    AssertStatus 1
}

@test "GIVEN not exisiting symbolic link, WHEN executing IsExisting, THEN return code 1" {
    run IsExisting ${not_existing_symbolic_link}

    AssertStatus 1
}

#
# IsReadable
#
@test "GIVEN readable file, WHEN executing IsReadable, THEN return code 0" {
    run IsReadable ${log_file}

    AssertStatus 0
}

@test "GIVEN not readable file, WHEN executing IsReadable, THEN return code 1" {
    run IsReadable ${not_readable_file}

    AssertStatus 1
}

#
# IsWriteable
#
@test "GIVEN writeable file, WHEN executing IsWriteable, THEN return code 0" {
    run IsWriteable ${log_file}

    AssertStatus 0
}

@test "GIVEN not writeable file, WHEN executing IsWriteable, THEN return code 1" {
    run IsWriteable ${not_writeable_file}

    AssertStatus 1
}

#
# IsExecutable
#
@test "GIVEN executable file, WHEN executing IsExecutable, THEN return code 0" {
    run IsExecutable ${log_file}

    AssertStatus 0
}

@test "GIVEN not executable file, WHEN executing IsWriteable, THEN return code 1" {
    run IsExecutable ${not_executable_file}

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

#
# AssertIsDirectory tests
#
@test "GIVEN existing direcotry, WHEN executing AssertIsDirectory, THEN return code 0" {
    run AssertIsDirectory ${test_folder_structure_short}

    AssertStatus 0
}

@test "GIVEN not existing directory, WHEN executing AssertIsDirectory, THEN fatal output with return code 1" {
    EnableRawLogging
    expected_output="Fatal: Directory ${not_existing_directory} does not exist"

    run AssertIsDirectory ${not_existing_directory}

    AssertStatus 1
    AssertOutput "${expected_output}"
}

#
# AssertIsExisting tests
#
@test "GIVEN existing file and direcotry, WHEN executing AssertIsExisting, THEN return code 0" {
    run AssertIsExisting ${log_file}
    AssertStatus 0
    
    run AssertIsExisting ${test_folder_structure_short}
    AssertStatus 0
}

@test "GIVEN not existing file and direcotry, WHEN executing AssertIsExisting, THEN return code 1" {
    run AssertIsExisting "${log_file}.old"
    AssertStatus 1
    
    run AssertIsExisting "${test_folder_structure_short}/asdf"
    AssertStatus 1
}

#
# AssertIsSymbolicLink
#
@test "GIVEN existing symbolic link, WHEN executing AssertIsSymbolicLink, THEN return code 0" {
    run AssertIsSymbolicLink "${symbolic_link_to_file}"

    AssertStatus 0
}

@test "GIVEN not existing symbolic link, WHEN executing AssertIsSymbolicLink, THEN return code 1" {
    run AssertIsSymbolicLink "${symbolic_link_to_file}.old"

    AssertStatus 1
}

#
# AssertIsReadable
#
@test "GIVEN existing readable file, WHEN executing AssertIsReadable, THEN return code 0" {
    run AssertIsReadable "${log_file}"

    AssertStatus 0
}

@test "GIVEN not readable file, WHEN executing AssertIsReadable, THEN return code 1" {
    run AssertIsReadable "${not_readable_file}"

    AssertStatus 1
}

#
# AssertIsWriteable
#
@test "GIVEN existing writeable file, WHEN executing AssertIsWriteable, THEN return code 0" {
    run AssertIsWriteable "${log_file}"

    AssertStatus 0
}

@test "GIVEN not writeable file, WHEN executing AssertIsWriteable, THEN return code 1" {
    run AssertIsWriteable "${not_writeable_file}"

    AssertStatus 1
}

#
# AssertIsExecutable
#
@test "GIVEN existing executable file, WHEN executing AssertIsExecutable, THEN return code 0" {
    run AssertIsExecutable "${log_file}"

    AssertStatus 0
}

@test "GIVEN not executable file, WHEN executing AssertIsExecutable, THEN return code 1" {
    run AssertIsExecutable "${not_executable_file}"

    AssertStatus 1
}
