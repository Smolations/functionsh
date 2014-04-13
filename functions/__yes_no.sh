## /* @function
#   @usage __yes_no --default=<y|n> <question_string>
#
#   @output true
#
#   @exports
#   $_ans
#   $_yes
#   $_no
#   exports@
#
#   @description
#   This function provides an easy way for presenting yes/no questions and then
#   using the answer (via exported variables) in script logic.
#   description@
#
#   @options
#   --default=<y|n>     Set whether the default answer is yes or no. Required.
#   options@
#
#   @examples
#   # ignore errors
#   __yes_no --default=n "Does this work"
#   if [ $_yes ]; then
#       ...
#   fi
#
#   # OR
#
#   # take into account if there is an error during processing within __yes_no
#   if __yes_no --default=n "Does this work" && [ $_yes ]; then
#       ...
#   fi
#   examples@
#
#   @dependencies
#   `egrep`
#   __in_args.sh
#   dependencies@
#
#   @returns
#   0 - successful execution
#   1 - less than 2 arguments were passed to function
#   2 - the --default option was not passed to function
#   4 - an invalid value (or no value) was given for the --default option
#   returns@
#
#   @file __yes_no.sh
## */

function __yes_no {
    # __debug "__yes_no() $@"

    _ans=
    _yes=
    _no=
    local default question Q="${X}${B}" A="${X}${B}${COL_MAGENTA}"

    # must pass --default option AND question
    if [ $# -lt 2 ]; then
        return 1
    fi

    # the --default option is required.
    if ! __in_args default "$@"; then
        return 2
    fi

    default="$_arg_val"
    question="$_args_clipped"

    # set default to be lowercase
    default="${default//N/n}"
    default="${default//Y/y}"
    # __log "__yes_no(): Default is '$default'"

    # validate input
    if [ -z "$default" ] || ! egrep -q '^[yn]$' <<< "$default"; then
        # echo
        # __err "__yes_no: You must choose a default answer by passing the --default option!"
        return 4
    fi

    optN=$([ "$default" = "n" ] && echo "${A}N${X}" || echo "n")
    optY=$([ "$default" = "y" ] && echo "${A}Y${X}" || echo "y")

    # -n to keep response on same line; -e to honor escapes like \n
    echo -ne "${Q}  ${question} ${X}[${optY}/${optN}]${Q}?${X}  "
    read ans
    # __log "__yes_no(): User answered '$ans'"
    [ -z "$ans" ] && ans=$default

    ans=$(egrep --only-matching '^[ynYN]$' <<< "$ans" 2>/dev/null)

    if [ -n "$ans" ]; then
        ans="${ans//Y/y}"
        ans="${ans//N/n}"
        _ans=$ans

    else
        # this should get triggered when an
        __yes_no --default=$default "$question"
    fi

    # __log "__yes_no(): \$_ans after processing is '${_ans}'"

    if [ -z "$_ans" ] || [ "$_ans" == "$default" ]; then
        [ "$default" = "y" ] && _yes=true || _no=true
    else
        [ "$ans" == "y" ] && _yes=true || _no=true
    fi

    export _yes _no _ans

    return 0
}
export -f __yes_no
