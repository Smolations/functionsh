## /* @function
#	@usage __show_tree <path_to_folder>
#
#	@output true
#
#	@description
#	Show a file tree using indents and colors. This function will recursively list
#	the contents of a given directory.
#	description@
#
#	@notes
#	- Dot folders are ignored by default.
#	notes@
#
#	@examples
#	$ __show_tree ~/Documents
#	examples@
#
#   @dependencies
#   `grep`
#   dependencies@
#
#   @returns
#   0 - function executes successfully
#   1 - if no arguments are given
#   2 - if provided argument is not a directory
#   returns@
#
#	@file __show_tree.sh
## */

function __show_tree {
	if [ -z "$1" ]; then
		# echo ${E}"  __show_tree: Path expected as first parameter.  "${X}
		return 1
	fi

	if [ ! -d "$1" ]; then
		# echo ${E}"  __show_tree: Path given is not a directory.  "${X}
		return 2
	fi

	local indent="$indent    " filePre="" folderPre=""

	if [ ! $inRecurse ]; then
		echo "${COL_YELLOW}$(cd "$1"; pwd)${X}"
	fi

	for entry in `ls $1`; do
		if [ -d "$1/$entry" ]; then
			export inRecurse=true
			grep -q '^\.' <<< "$entry" && continue
			echo "${indent}${folderPre}${COL_YELLOW}${entry}${X}"
			__show_tree "$1/$entry"

		else
			echo "${indent}${filePre}${entry}"
		fi
	done

	unset inRecurse

	return 0
}
export -f __show_tree
