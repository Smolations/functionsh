## /* @function
 #  @usage __center <line-length> <string>
 #
 #  @output true
 #
 #  @description
 #  Center a given <string> within <line-length> characters.
 #  description@
 #
 #  @examples
 #  $ __center 10 hi
 #  >     hi
 #
 #  $ __center 10 "hello mother"
 #  # returns code 8; <string> is longer than <line-length>
 #  examples@
 #
 #  @dependencies
 #  `bc`
 #  `egrep`
 #  `tr`
 #  functions/__strlen.sh
 #  dependencies@
 #
 #  @returns
 #  0 - successful execution
 #  1 - invalid number of arguments passed
 #  2 - invalid value for <line-length>
 #  4 - failed to find length of <string>
 #  8 - length of <string> is greater than <line-length>
 #  returns@
 #
 #  @file functions/__center.sh
 ## */

function __center {
    local retVal=0 lead strLen lineLen

    if [ $# -lt 2 ]; then
        retVal=1

    elif ! egrep -q '^\d+$' <<< "$1"; then
        retVal=2

    else
        lineLen=$1
        shift
        strLen=$( __strlen "$@" | tr -d '\n' )

        if ! egrep -q '^\d+$' <<< "$strLen"; then
            retVal=4

        elif (( strLen > lineLen )); then
            retVal=8

        else
            lead=$( echo "($lineLen - $strLen) / 2" | bc )
            printf "%${lead%%.*}s%s\n" " " "$@"
        fi
    fi

    return $retVal
}
export -f __center
