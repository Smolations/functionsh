## /* @function
 #  @usage __in_args <arg_name> "$@"
 #
 #  @output false
 #
 #  @exports
 #  $_arg_val
 #  $_arg_index
 #  $_args_clipped
 #  exports@
 #
 #  @description
 #  Tired of looping through arguments to find the one you want? Say hello to
 #  `__in_args`. Simply pass name of the option (without any leading hyphens) along
 #  with the "all args" Bash variable ("$@"; make sure it's always wrapped in double
 #  quotes!) and the function will return 0 or 1 if the option is found or isn't
 #  found, respectively. The function will export the $_arg_val variable populated
 #  with the value (if any) associated with the given <arg_name> (only for GNU-style;
 #  see @notes below).
 #
 #  In addition to the value of the option (if applicable), the function will also
 #  export the $_arg_index variable which holds the 0-based index of where the
 #  argument was found in the argument list.
 #
 #  If further parsing is required, `__in_args` conveniently exports the original
 #  arguments, sans the passed-in search arg, into the $_args_clipped variable. You
 #  can then pass the exported variable into your next `__in_args` call.
 #  description@
 #
 #  @notes
 #  - THIS WILL NOT WORK WITH XF86-style long options (e.g. -myoption). Each letter
 #  in the long option will be treated as a POSIX-style single option
 #  (e.g. -m, -y, -o, etc.).
 #  - This function does not look for arguments of POSIX-style single options.
 #  Passing something like "-a /some/path" will not yield "/some/path" in $_arg_val.
 #  If your script requires arguments for options, use a GNU-style long option
 #  (e.g. --option=foo).
 #  - This function is meant to be used in conditionals. Do NOT test for the
 #  existence of the exported variables in your code. The exported variables will
 #  always exist.
 #  notes@
 #
 #  @examples
 #  # assume arguments passed to calling script were:
 #  #   -a --quiet --dry-run=first
 #  __in_args quiet "$@"          # returns 0 (success) matches: --quiet
 #                                #          $_arg_val =
 #                                #        $_arg_index = 1
 #                                #     $_args_clipped = -a  --dry-run=first
 #  __in_args a "$@"              # returns 0 (success) matches: -a
 #                                #          $_arg_val =
 #                                #        $_arg_index = 0
 #                                #     $_args_clipped = --quiet --dry-run=first
 #  __in_args -a "$@"             # returns 2 (failure) should not include hyphen
 #                                #          $_arg_val =
 #                                #        $_arg_index =
 #                                #     $_args_clipped = -a --quiet --dry-run=first
 #  __in_args dry-run "$@"        # returns 0 (success) matches: --dry-run
 #                                #          $_arg_val = first
 #                                #        $_arg_index = 2
 #                                #     $_args_clipped = -a --quiet
 #
 #  # use only in conditionals thusly:
 #  if __in_args "a" "$@"; then
 #      if __in_args "quiet" "$_args_clipped"; then
 #          git add -A . &> /dev/null
 #      else
 #          git add -A .
 #      fi
 #  fi
 #
 #  if __in_args dry-run "$@"; then
 #      runType="$_arg_val"
 #      # ...do something with $runType...
 #  fi
 #  examples@
 #
 #  @dependencies
 #  `sed`
 #  `egrep`
 #  dependencies@
 #
 #  @returns
 #  0 - specified argument found in given input
 #  1 - less than 2 arguments were provided
 #  2 - specified argument not found in given input
 #  returns@
 #
 #  @file functions/__in_args.sh
 ## */

function __in_args {
    if [ $# -lt 2 ]; then
        # __err "__in_args expects at least 2 arguments! ${#} given."
        # __log "    \$@:  ${@}"
        return 1
    fi

    # __debug "__in_args received:  $@"

    local retVal=2 option optionLength allArgs patt ndx sedPatt newArg

    # initialize return val/vars
    _arg_val=
    _arg_index=
    _args_clipped=

    # grab option to search for and shift it off parameter array
    option="$1"
    optionLength=${#option}
    shift

    # save all the arguments passed as the second param for use with _args_clipped
    allArgs="$@"
    _args_clipped="$allArgs"

    # different processing depending on the type of argument
    if [ $optionLength == 1 ]; then
        # POSIX-style single option/flag/switch (e.g. -a or -abc where abc contains 3 options)
        patt="^-[a-z]*${option}[a-z]*$"
        ndx=0
        until [ $# == 0 ]; do
            # __debug "__in_args matching:  ${1}"
            if egrep --quiet --ignore-case $patt <<< "$1"; then
                [ ${#1} -gt 2 ] && sedPatt="$option" || sedPatt="-${option}"
                newArg=$(sed "s/${sedPatt}//" <<< "$1")
                _args_clipped=$(sed "s/${1}/${newArg}/" <<< "$allArgs")
                _arg_index=$ndx

                retVal=0
                break
            fi
            shift
            (( ndx++ ))
        done

    else
        # GNU-style long option (e.g. --option or --option=foo)
        patt="^--${option}(=|$)"
        ndx=0
        until [ $# == 0 ]; do
            # __debug "__in_args matching:  ${1}"
            if egrep --quiet $patt <<< "$1"; then
                if egrep --quiet '=' <<< "$1"; then
                    _arg_val="${1#*=}"
                fi

                _args_clipped=$(sed "s+${1}++" <<< "$allArgs")
                _arg_index=$ndx

                retVal=0
                break
            fi
            shift
            (( ndx++ ))
        done
    fi

    # trim _args_clipped
    [ -n "$_args_clipped" ] && _args_clipped=$(sed -E 's<^ +| +$<<' <<< "$_args_clipped")

    # __debug "__in_args:       _arg_val = ${_arg_val}"
    # __debug "__in_args:     _arg_index = ${_arg_index}"
    # __debug "__in_args:  _args_clipped = ${_args_clipped}"

    export _arg_val _arg_index _args_clipped
    return $retVal
}
export -f __in_args
