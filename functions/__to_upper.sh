## /* @function
 #  @usage __to_upper <string>
 #
 #  @output true
 #
 #  @description
 #  Convert a string into all uppercase letters.
 #  description@
 #
 #  @examples
 #  $ __to_upper "Hello friend"
 #  > HELLO FRIEND
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
 #  @file functions/__to_upper.sh
 ## */

function __to_upper {
    awk '{ print toupper($0) }' <<< "$@"
}
