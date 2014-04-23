## /* @function
 #  @usage __path_remove <path-to-remove> [<target-path-var>]
 #
 #  @output false
 #
 #  @exports
 #  $PATH   - or whatever variable is passed as the second parameter
 #  exports@
 #
 #  @description
 #  Remove a path element from $PATH. Second argument is the name of the
 #  path variable to be modified (default: PATH).
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
