# Bash utility functions
This repo contains a collection of bash helper function which are most likely used in the daily scripting with bash. Yeah I probably know what you think! Most of the devs will say: "Bla bla bla just use python for it bla bla bla".

I have to admit yes it feels a bit strange to still write bash scripts but if you want to write a small script you probably dont want to use the python club.


# How to use it
Just clone it into your favorite directory and source the bash utility componente(e.g logging, filesystem, ...) you want to use. All bash utility componets are written in a way that they include the needed ones in the right way and only once! For example:

```
#!/bin/bash

source logging/src/logging.bash
source parameter_utility/src/parameter_utility.bash

function main()
{
    Info "Welcome to main"
    
    RegisterParameter "-i" "Info" "Wrapper for the Info function" "Info"
    RegisterParameter "-f" "Fatal" "Wrapper for Fatal function" "Fatal"
    RegisterParameter "-d" "Die" "Wrapper for Die function. This will terminate with return code 1" "Die"

    ProcessParameters "$@"
}

main "$@"
```

To see the help text use:

```./my_script.sh -h```

Print info:

```./my_script.sh -i "My info message"```

Analog behavior can be expected for -f and -d. Of course with different output ;D... 


# TODO
- Doxygen for each defined function. Currently nothing is documented... yep thats crap im working on it :)
- Test coverage
- Mocks for commands we do not want to execute (e.g. sudo, git clone, ...)
- Ideas or even implementations are highly welcome. Just do not forget to test your stuff in the same pattern otherwise I will simply reject it.
