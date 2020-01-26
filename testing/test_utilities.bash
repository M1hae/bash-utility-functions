function AssertStatus()
{
    echo -e "Expected: ${1}\nActual: ${status}"
    [[ "${status}" -eq ${1} ]]
}

#Since we are comparing strings on console we need an ultra verbose logging output
function AssertOutput()
{
    echo "Expected:"
    echo -e "${1}" | tr -dc '[:print:]' | od -c
    echo "Actual:"
    echo -e "${output}" | tr -dc '[:print:]' | od -c
    [[ "${output}" = "${1}" ]]
}