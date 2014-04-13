## /* @function
#   @usage __strip_color_codes [<data_string> [<data_string> [...]]]
#
#   @output true
#
#   @description
#   In preparation for logging information (or sending information somewhere that
#   does not play well with color codes) characters which designate colors are
#   stripped from the input.
#   description@
#
#   @dependencies
#   `sed`
#   dependencies@
#
#   @file __strip_color_codes.sh
## */

function __strip_color_codes {
    sed -E 's:'$'\033\[[0-9]+m''::g' <<< "$@"
}
export -f __strip_color_codes
