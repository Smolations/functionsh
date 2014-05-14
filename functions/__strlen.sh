## /* @function
 #  @usage __strlen <string>
 #
 #  @output true
 #
 #  @description
 #  Calculate the number of characters in a given <string>.
 #  description@
 #
 #  @notes
 #  - This WILL count newline characters! Keep in mind that echo statements include
 #  a trailing newline character unless the -n option is specified.
 #  notes@
 #
 #  @examples
 #  $ __strlen "hey mom"
 #  > 7
 #  examples@
 #
 #  @dependencies
 #  `wc`
 #  `tr`
 #  `egrep`
 #  dependencies@
 #
 #  @returns
 #  0 - successful execution
 #  1 - an error occurred with `wc` or `tr` used to get character count
 #  returns@
 #
 #  @file functions/__strlen.sh
 ## */

function __strlen {
    local len retVal=0

    if [ -z "$@" ]; then
        len=0

    else
        len=$( wc -c <<< "$@" | tr -d '\n\t ' )

        if egrep -q '^\d+$' <<< "$len"; then
            (( len-- ))
        else
            retVal=1
        fi
    fi

    [ $retVal == 0 ] && echo $len

    return $retVal
}
export -f __strlen
