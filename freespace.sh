#!/bin/bash

# Runs the 'file' command on the input, determines the file type by isolating the second field of the output using awk.
function get_file_type() {
	echo $(file $1) | awk '{print $2}'
}

function mv_file() {
	if [[ !("$1" == "fc-*") ]]; then
		FILENAME="fc-$1"
		mv "$1" "$FILENAME"
		touch "$FILENAME"
	fi
}

function compress_logic() {
	# $1 is the file
	# $2 is the file type
	case "$2" in
	"gzip" | "bzip2" | "Zip" | "compress'd")
		mv_file "$1"
		;;
	*)
		zip "fc-$1" "$1"
		;;
	esac

}

export -f compress_logic

function directory_pack() {
	if [[ "$1" == "-r" ]]; then
		echo "$2"
		find "$2" -type f -exec bash -c 'compress_logic "$(basename "$0")"' {} \;
	fi

	if [[ "$1" == "!r" ]]; then
		find "$2" -maxdepth 1 -type f | rev | cut -d "/" -f 1 | rev
		#-exec bash -c 'compress_logic "${1#./}"' _ {} \;
	fi
}

TIME=48
RECURSIVE=
OPTSTRING="rt:"

while getopts ${OPTSTRING} opt; do
	case ${opt} in
	t)
		TIME=${OPTARG}
		shift $(($OPTIND - 1))
		;;
	r)
		DIRECTORY=${!OPTIND}
		if [[ !(-d $DIRECTORY) ]]; then
			echo "Option $opt -${OPTARG} requires a directory."
			exit 1
		else
			RECURSIVE=1
		fi
		;;
	:)
		echo "Option $opt -${OPTARG} requires an argument."
		exit 1
		;;
	?)
		echo "Invalid option: -${OPTARG}."
		exit 1
		;;
	esac
done

minutes=$(($TIME * 60))
find . -name "fc-*" -type f -mmin +$minutes -delete

if [[ ! -z "$RECURSIVE" ]]; then
	directory_pack "-r" "${!OPTIND}"
elif [[ -d "${!OPTIND}" ]]; then
	directory_pack "!r" "${!OPTIND}"
else
	zip "fc-${!OPTIND}" "${!OPTIND}"
fi
