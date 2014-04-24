## /* @function
 #  @usage __str_repeat <string> <num>
 #
 #  @output true
 #
 #  @description
 #  In cases where you need a small number of characters repeated a certain number
 #  of times, this function will solve your problem. It will send the <string>
 #  repeated <num> times to STDOUT.
 #  description@
 #
 #  @dependencies
 #  `egrep`
 #  dependencies@
 #
 #  @returns
 #  0 - successful execution
 #  1 - missing or excessive arguments
 #  2 - value passed for <num> is not a number
 #  returns@
 #
 #  @file functions/__str_repeat.sh
 ## */

function __str_repeat {
    [ $# != 2 ] && return 1
    local str=$1 mult=$2 out i
    ! egrep -q '^[0-9]+$' <<< $mult && return 2

    for i in $( seq $mult ); do out="${out}${str}"; done

    echo $out
}
export -f __str_repeat
