function AssertStatus()
{
    echo -e "Expected: ${1}\nActual: ${status}"
    [[ "${status}" -eq ${1} ]]
}

#Since we are comparing strings on console we need an ultra verbose logging output
function AssertOutput()
{
    echo "Expected:"
    echo "${1}" | od -c
    echo "Actual:"
    echo "${output}" | od -c
    [[ "${output}" = "${1}" ]]
}