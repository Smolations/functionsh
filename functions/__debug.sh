## /* @function
#   @usage __debug [<data_string> [<data_string> [...]]]
#
#   @output false
#
#   @description
#   Send debug information to __log, automatically prepended with an
#   identifiable label ([DEBUG]).
#   description@
#
#   @examples
#   $ __debug "myVar = $myVar"
#   examples@
#
#   @dependencies
#   __log.sh
#   dependencies@
#
#   @file __debug.sh
## */

function __debug {
    __log "[DEBUG]  $@"
}
export -f __debug
