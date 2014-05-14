## /* @function
 #  @usage __to_lower <string>
 #
 #  @output true
 #
 #  @description
 #  Convert a string into all lowercase letters.
 #  description@
 #
 #  @examples
 #  $ __to_lower "HEY guys"
 #  > hey guys
 #  examples@
 #
 #  @dependencies
 #  `awk`
 #  dependencies@
 #
 #  @returns
 #  exit code from `awk`
 #  returns@
 #
 #  @file functions/__to_lower.sh
 ## */

function __to_lower {
    awk '{ print tolower($0) }' <<< "$@"
}
