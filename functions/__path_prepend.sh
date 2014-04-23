## /* @function
 #  @usage __path_prepend <path-to-prepend> [<target-path-var>]
 #
 #  @output false
 #
 #  @exports
 #  $PATH   - or whatever variable is passed as the second parameter
 #  exports@
 #
 #  @description
 #  Prepend a path element to $PATH. Second argument is the name of the
 #  path variable to be modified (default: PATH).
 #  description@
 #
 #  @dependencies
 #  functions/__path_remove.sh
 #  dependencies@
 #
 #  @file functions/__path_prepend.sh
 ##

function __path_prepend {
    __path_remove $1 $2
    local PATHVARIABLE=${2:-PATH}
    export $PATHVARIABLE="$1${!PATHVARIABLE:+:${!PATHVARIABLE}}"
}
export -f __path_prepend
