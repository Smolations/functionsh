## /* @function
 #  @usage __log [-n] [--file=<path>] [<data_string> [<data_string> [...]]]
 #
 #  @output false
 #
 #  @description
 #  Log some information to the file specified by $FUNCTIONSH_LOG_PATH, or by the
 #  <path> (NOT a folder) supplied by the user using the --file option. Using
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
 #      3. If a project requires sourcing scripts instead of executing, create a
 #         wrapper function around __log and pass it the --file option with the
 #         project-specific log file. The only downside to this method is that
 #         piped input will no longer work (unless the user implements it).
 #  description@
 #
 #  @options
 #  --file=<path>   Path to custom log file. If the doesn't exist, there will be
 #                  an attempt to create it. The parent directory must exist.
 #  -n              Do not prepend a timestamp to the log output. Data will still
 #                  be logged with the same indentation as if it had the timestamp.
 #  options@
 #
 #  @notes
 #  - This function will accept piped input, as seen in the examples below. it does
 #  NOT, however, work well taking piped input from longer-running processes (e.g.):
 #      $ tail -f $file | __log
 #  - The default timestamp as seen in the log has no preceding spaces but
 #  includes 2 trailing spaces (e.g.): [2014-04-12 14:47:40]
 #  notes@
 #
 #  @examples
 #  $ __log "The build cannot be started."
 #  $ git merge master | __log --file=~/Library/Logs/gitlog.log
 #  examples@
 #
 #  @dependencies
 #  $FUNCTIONSH_LOG_PATH
 #  `date`
 #  functions/__is_stdin.sh
 #  functions/__strip_color_codes.sh
 #  dependencies@
 #
 #  @returns
 #  0 - function executed successfully
 #  1 - could not determine path to log
 #  2 - log file could not be created
 #  returns@
 #
 #  @file functions/__log.sh
 ## */

function __log {
    local noStamp data pre i log_file="$FUNCTIONSH_LOG_PATH"

    # not using __in_args due to pipe considerations
    for i in {1..3}; do
        if [ "$1" == "-n" ]; then
            noStamp=true
            shift

        elif grep -q '\-\-file\=' <<< "$1"; then
            log_file="${1#*=}"
            shift

        # for backwards compatibility until other projects remove the -p option
        elif [ "$1" == "-p" ]; then
            shift
        fi
    done

    [ -z "$log_file" ] && return 1
    [ ! -f "$log_file" ] && ! touch "$log_file" 2>/dev/null && return 2

    pre="[$(date "+%Y-%m-%d %H:%M:%S")]  "
    data="$@"

    if [ $noStamp ]; then
        # this processing ensures that the indentation of the output starts at the
        # same place as if the date prefix were included. if this functionality is
        # not desired, simply set pre="".
        pre=$( printf "%$(wc -c <<< "$pre")s" );
        pre="${pre:1}"
    fi

    if __is_stdin; then
        cat - | while IFS= read data; do
            echo -e "${pre}$(__strip_color_codes "$data")" >> "$log_file"
        done

    else
        echo -e "${pre}$(__strip_color_codes "$data")" >> "$log_file"
    fi
}
export -f __log
