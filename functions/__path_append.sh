## /* @function
 #  @usage __path_append <path> [<target_path_var>]
 #
 #  @output false
 #
 #  @exports
 #  $PATH   - or ${<target_path_var>}
 #  exports@
 #
 #  @description
 #  Append a <path> element to $PATH by default, or <target_path_var> if given.
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
