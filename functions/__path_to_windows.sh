## /* @function
#   @usage __path_to_windows <path>
#
#   @output true
#
#   @description
#   There are a small number of operations (at the time of this writing) which require
#   access to the Windows cmd.exe. When passing paths to `cmd`, they must be using
#   the native windows format. This function will convert any path, relative or absolute,
#   into a Windows-compatible path.
#   description@
#
#   @notes
#   - This function does NOT validate that the path exists. It simply performs some
#   find/replace/substring operations to get the desired path.
#   - This function will always return true unless no parameters are given.
#   notes@
#
#   @examples
#   __path_to_windows "${functionsh_path%/}"
#   examples@
#
#   @dependencies
#   `grep`
#   dependencies@
#
#   @returns
#   0 - function executes successfully
#   1 - if no arguments are given
#   returns@
#
#   @file __path_to_windows.sh
## */

function __path_to_windows {
    [ -z "$@" ] && return 1

    local path="$@"
    path="${path#/}"

    if grep -q '^[a-z]\/' <<< "$path"; then
        # path starts with a drive letter
        path="${path:0:1}:${path:1}"
    fi

    path="${path//\//\\}"

    echo $path

    return 0
}
export -f __path_to_windows
