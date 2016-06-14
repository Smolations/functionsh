## /* @function
 #  @usage __path_prepend <path> [<target_path_var>]
 #
 #  @output false
 #
 #  @exports
 #  $PATH   - or ${<target_path_var>}
 #  exports@
 #
 #  @description
 #  Prepend a <path> element to $PATH by default, or <target_path_var> if given.
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
