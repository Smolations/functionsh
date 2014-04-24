## /* @function
 #  @usage __source_all [<path>]
 #
 #  @output false
 #
 #  @description
 #  This function will source all files in the given <path>, bringing any
 #  exported variables into the calling context. Given folders are searched
 #  recursively. If no <path> is provided, the current directory is sourced.
 #  Because of this, be very intentional about how you use this function.
 #  description@
 #
 #  @notes
 #  - The given <path> can be handled whether it ends with a slash (/) or not.
 #  - The given <path> can be relative to the current directory or absolute.
 #  notes@
 #
 #  @examples
 #  __source_all "/some/path/to/folder"
 #  examples@
 #
 #  @returns
 #  0 - successful execution
 #  1 - given <path> is not a directory
 #  returns@
 #
 #  @file functions/__source_all.sh
 ## */

function __source_all {
    local arg retVal=0

    [ $# == 0 ] && arg=$(pwd) || arg="${@%/}"

    if [ -d "$arg" ]; then
        for file in "${arg}/"*; do

            if [ -d "$file" ]; then
                __source_all "$file"

            elif [ -s "$file" ]; then
                # echo "Going to source: ${file}"
                source "$file"
            fi

        done

    else
        retVal=1
    fi

    return $retVal
}
export -f __source_all
