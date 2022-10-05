#!/bin/sh

which find > /dev/null 2>&1 || (echo "Missing find, please install it." ; exit 1)

checker() {
  if [ -d "${1}" ] ; then
    count=$(find "${1}" | wc -l)
    if [ "${count}" -lt 2 ] ; then
      echo "The directory ${1} is empty."
      return 1
    fi
  fi
}

while getopts 'f:d:' OPTION; do
  case "$OPTION" in
    f)
      sub_folder="$OPTARG"
      ;;
    d)
      maxdepth="$OPTARG"
      ;;
    *)
      echo "Unknow argument: $0 [-f path]" >&2
      exit 1
    ;;
  esac
done
shift "$(($OPTIND -1))"

if [ -z "$sub_folder" ]; then
  sub_folder="."
fi

if [ -z "$maxdepth" ]; then
  maxdepth=1
fi

find $sub_folder/ -maxdepth $maxdepth -type d -not -name '.*' | while read -r dir ; do
  checker "$dir"
done
