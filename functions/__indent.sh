## /* @function
 #  @usage __indent [--char=<char>] <num> <string>
 #
 #  @output true
 #
 #  @description
 #  Sometimes, over the course of a program, there are blocks of text you'd
 #  like to indent, but changing the indent later would be a pain. This function
 #  solves that problem. It will indent a given <msg> using <num> characters.
 #  The default indent character is a single space, but can be configured using
 #  the --char option.
 #  description@
 #
 #  @options
 #  --char=<char>  The character which makes up the indentation (default is a
 #                 single space).
 #  options@
 #
 #  @notes
 #  - Technically, <char> doesn't have to be a single character. The user will
 #  need to take into the number of characters chosen for <char> and multiply
 #  it by <num> to determine the total number of characters in the indent.
 #  - You may have noticed that `printf` is quite capable of doing a job like
 #  this. It still poses the problem of having spaces (or a common variable)
 #  in the `printf` string.
 #  - Try to avoid any <char>'s which may conflict with basic `sed` regex.
 #  notes@
 #
 #  @examples
 #  $ __indent 4 "i'm indented 4 spaces."
 #      i'm indented 4 spaces.
 #  $ __indent --char=. 2 "to be continued"
 #  ..to be continued
 #  $ __indent --char='>+' 3 " this technically works"
 #  >+>+>+ this technically works
 #
 #  ind=3
 #  __indent $ind "This is a message..."
 #  __indent $ind "...which will be left aligned with *this* message."
 #  examples@
 #
 #  @dependencies
 #  `egrep`
 #  functions/__in_args.sh
 #  functions/__str_repeat.sh
 #  dependencies@
 #
 #  @returns
 #  0 - successful execution
 #  1 - less than 2 arguments were passed to function
 #  2 - an invalid <num> was passed (it wasn't recognized as a number)
 #  returns@
 #
 #  @file functions/__indent.sh
 ##

function __indent {
    [ $# -lt 2 ] && return 1

    local num msg ind chr=' '

    if __in_args char "$@"; then
        chr="$_arg_val" && shift
    fi

    ! egrep --quiet '^[0-9]+$' <<< "$1" && return 2

    num=$1 && shift && msg="$@"
    ind=$( IFS=$'\n'; __str_repeat "$chr" $num )
    ( IFS=$'\n'; echo "${ind}${msg}" )
}
export -f __indent
