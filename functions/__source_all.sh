## /* @function
#   @usage __source_all <path>
#
#   @description
#   This function will source all files in the given directory, bringing any
#   exported variables into the calling context. Given folders are searched
#   recursively.
#   description@
#
#   @examples
#   __source_all "/some/path/to/folder"
#   examples@
#
#   @file __source_all.sh
## */

function __source_all {
    local arg="${1%/}"

    if [ -d "$arg" ]; then
        for file in "${arg}/"*; do

            if [ -d "$file" ]; then
                __source_all "$file"

            elif [ -s "$file" ]; then
                # echo "Going to source: ${file}"
                source "$file"
            fi

        done
    fi
}
export -f __source_all
