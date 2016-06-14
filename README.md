functionsh
==========

A collection of (mostly) independent functions intended to make Bash scripting a little easier for Bash scripters.


Usage
-----

Below is a list of usages for the various available functions included in this library. The definitions are straight from the documentation in the files themselves. See each file's source for more details.

    [__center](functions/__center.sh) <line-length> <string>
    [__debug](functions/__debug.sh) [<data_string> [<data_string> [...]]]
    [__elog](functions/__elog.sh) [<data_string> [<data_string> [...]]]
    [__error](functions/__error.sh) [<data_string> [<data_string> [...]]]
    [__get_env](functions/__get_env.sh) [-e]
    [__in_args](functions/__in_args.sh) <arg_name> "$@"
    [__in_array](functions/__in_array.sh) <needle> <haystack>
    [__indent](functions/__indent.sh) [--char=<char>] <num> <string>
    [__is_stdin](functions/__is_stdin.sh)
    [__log](functions/__log.sh) [-n] [--file=<path>] [<data_string> [<data_string> [...]]]
    [__menu](functions/__menu.sh) [--prompt=<msg>] <list_item> [<list_item>] ... ] [-k <list_item> [<list_item>] ...]
    [__path_append](functions/__path_append.sh) <path> [<target_path_var>]
    [__path_prepend](functions/__path_prepend.sh) <path> [<target_path_var>]
    [__path_remove](functions/__path_remove.sh) <path> [<target_path_var>]
    [__path_to_windows](functions/__path_to_windows.sh) <path>
    [__short_ans](functions/__short_ans.sh) <prompt>
    [__show_tree](functions/__show_tree.sh) [<path>]
    [__source_all](functions/__source_all.sh) [-vx] [<path>]
    [__str_repeat](functions/__str_repeat.sh) [-n] <string> <num>
    [__strip_color_codes](functions/__strip_color_codes.sh) [<data_string> [<data_string2> [...]]]
    [__strlen](functions/__strlen.sh) <string>
    [__to_lower](functions/__to_lower.sh) <string>
    [__to_upper](functions/__to_upper.sh) <string>
    [__type_exists](functions/__type_exists.sh) [-p | -a | -b | -f | -k] <command>
    [__type_exists](functions/__type_exists.sh) [-p | -a | -b | -f | -k] <app_name>
    [__wait_on](functions/__wait_on.sh) [--max-time=<seconds>] <processID> [<wait_message>]
    [__yes_no](functions/__yes_no.sh) --default=<y|n> <question>
