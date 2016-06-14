## /* @function
 #  @usage __is_stdin
 #
 #  @output false
 #
 #  @description
 #  Determine if piped input is being streamed.
 #  description@
 #
 #  @examples
 #  if __is_stdin; then
 #      cat - | while IFS= read data; do
 #          # stuff with each line...
 #      done
 #  else
 #      # stuff with $@
 #  fi
 #  examples@
 #
 #  @returns
 #  0 - successful execution
 #  1 - failed execution
 #  returns@
 #
 #  @file functions/__is_stdin.sh
 ## */

function __is_stdin {
    [ "$( tty )" == 'not a tty' ]
}
export -f __is_stdin
