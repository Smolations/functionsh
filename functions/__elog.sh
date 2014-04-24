## /* @function
 #  @usage __elog [<data_string> [<data_string> [...]]]
 #
 #  @output true
 #
 #  @description
 #  Send log information to `__log`, prepending with an identifiable label ([ECHO]).
 #  Then, echo the information to STDOUT.
 #  description@
 #
 #  @examples
 #  $ __elog "Your branch name: $branch"
 #  examples@
 #
 #  @dependencies
 #  functions/__log.sh
 #  dependencies@
 #
 #  @file functions/__elog.sh
 ## */

function __elog {
    __log "[ECHO]  $@"
    echo "$@"
}
export -f __elog
