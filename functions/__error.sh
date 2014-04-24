## /* @function
 #  @usage __error [<data_string> [<data_string> [...]]]
 #
 #  @output true
 #
 #  @description
 #  Send error information to `__log` and echo it (with formatting) to STDERR. This
 #  function is meant to be used for issuing generic errors during the processing of
 #  scripts.
 #  description@
 #
 #  @notes
 #  - This function is aesthetically best for single-line errors.
 #  notes@
 #
 #  @examples
 #  $ __error "This function expects 2 arguments!"
 #  examples@
 #
 #  @dependencies
 #  functions/__log.sh
 #  dependencies@
 #
 #  @file functions/__error.sh
 ## */

function __error {
    __log "[ERROR]  $@"
    echo "${E}  $@  ${X}" 1>&2
}
export -f __error
