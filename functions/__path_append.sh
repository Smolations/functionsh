## /* @function
 #  @usage __path_append <path-to-append> [<target-path-var>]
 #
 #  @output false
 #
 #  @exports
 #  $PATH   - or whatever variable is passed as the second parameter
 #  exports@
 #
 #  @description
 #  Append a path element to $PATH. Second argument is the name of the
 #  path variable to be modified (default: PATH).
 #  description@
 #
 #  @dependencies
 #  functions/__path_remove.sh
 #  dependencies@
 #
 #  @file functions/__path_append.sh
 ##

function __path_append {
    __path_remove $1 $2
    local PATHVARIABLE=${2:-PATH}
    export $PATHVARIABLE="${!PATHVARIABLE:+${!PATHVARIABLE}:}$1"
}
export -f __path_append
