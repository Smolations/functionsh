## /* @function
 #  @usage __log [-n] [<data_string> [<data_string> [...]]]
 #  @usage <command> | __log -p [-n]
 #
 #  @output false
 #
 #  @description
 #  Log some information to the file specified by $FUNCTIONSH_LOG_PATH. Using
 #  a global variable to specify the log file path does not necessarily limit
 #  this function's usefulness. When executing a script (as opposed to sourcing
 #  it), Bash opens a new subprocess. This subprocess can see all of the
 #  exported variables from the parent process, but no matter how hard it may try,
 #  the subprocess cannot export any variables into the parent process's context.
 #  This means that the value of $FUNCTIONSH_LOG_PATH can be set at the top of
 #  a script, the script will log any messages sent to __log to that file, and,
 #  when the script is finished executing, the subprocess will close, and any
 #  further messages sent to __log will be logged to whatever $FUNCTIONSH_LOG_PATH
 #  was originally set in the parent process.
 #
 #  Given the behavior of $FUNCTIONSH_LOG_PATH, recommended usage is as follows:
 #      1. For a global, generic log file, set the value of $FUNCTIONSH_LOG_PATH
 #         in ~/.bashrc
 #      2. When logging is necessary for a script, set the value of
 #         $FUNCTIONSH_LOG_PATH at the top of the script, and write the script
 #         in a manner designed for execution of the script.
 #  description@
 #
 #  @options
 #  -n     Do not prepend a timestamp to the log output. Data will still be logged
 #         with the same indentation as if it had the timestamp.
 #  -p     Tell the function to expect piped input.
 #  options@
 #
 #  @notes
 #  - This function will accept piped input, as seen in the examples below. it does
 #  NOT, however, work well taking piped input from longer-running processes (e.g.):
 #      $ tail -f $file | __log -p
 #  - The default timestamp as seen in the log has no preceding spaces but
 #  includes 2 trailing spaces (e.g.): [2014-04-12 14:47:40]
 #  notes@
 #
 #  @examples
 #  $ __log "The build cannot be started."
 #  $ git merge master | __log -p
 #  examples@
 #
 #  @dependencies
 #  `date`
 #  $FUNCTIONSH_LOG_PATH - path to the text file for logging
 #  functions/__strip_color_codes.sh
 #  dependencies@
 #
 #  @returns
 #  0 - function executed successfully
 #  1 - $FUNCTIONSH_LOG_PATH is empty
 #  2 - $FUNCTIONSH_LOG_PATH is not a file
 #  returns@
 #
 #  @file functions/__log.sh
 ## */

function __log {
    [ -z "$FUNCTIONSH_LOG_PATH" ] && return 1
    [ ! -f "$FUNCTIONSH_LOG_PATH" ] && return 2

    local noStamp piped data pre="[$(date "+%Y-%m-%d %H:%M:%S")]  "

    until [ $# == 0 ]; do
        case $1 in
            -n)
                noStamp=true;;
            -p)
                piped=true;;
            *)
                [ -z "$data" ] && data="$1" || data="${data} ${1}";;
        esac
        shift
    done

    if [ $noStamp ]; then
        # this processing ensures that the indentation of the output starts at the
        # same place as if the date prefix were included. if this functionality is
        # not desired, simply set pre="".
        pre=$( printf "%$(wc -c <<< "$pre")s" );
        pre="${pre:1}"
        shift
    fi

    if [ $piped ]; then
        while read -t1 datum; do
            echo -e "${pre}$(__strip_color_codes "$datum")" >> "$FUNCTIONSH_LOG_PATH"
        done

    else
        echo -e "${pre}$(__strip_color_codes "$data")" >> "$FUNCTIONSH_LOG_PATH"
    fi
}
export -f __log
