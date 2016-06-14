## /* @function
 #  @usage __path_remove <path> [<target_path_var>]
 #
 #  @output false
 #
 #  @exports
 #  $PATH   - or ${<target_path_var>}
 #  exports@
 #
 #  @description
 #  Remove a <path> element from $PATH by default, or <target_path_var> if given.
 #  description@
 #
 #  @file functions/__path_remove.sh
 ##

function __path_remove {
    local IFS=':' PATHVARIABLE=${2:-PATH}
    local NEWPATH DIR

    for DIR in ${!PATHVARIABLE} ; do
        [ "$DIR" != "$1" ] && NEWPATH=${NEWPATH:+$NEWPATH:}$DIR
    done

    export $PATHVARIABLE="$NEWPATH"
}
export -f __path_remove
