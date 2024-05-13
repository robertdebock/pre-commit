#!/bin/sh

which wc > /dev/null 2>&1 || (echo "Missing wc, please install it." ; exit 1)

checker() {
  for folder in ${1} ; do
    if [ -f "${folder}/main.yml" ] ; then
      count=$(wc -l < "${folder}/main.yml")
      min_num=$2
      if [ "$(( count * 1 ))" -le "$(( min_num * 1 ))" ] ; then
        echo "The file ${folder}/main.yml is empty."
        return 1
      fi
    fi
  done
}

while getopts 'f:l:' OPTION; do
  case "$OPTION" in
    f)
      sub_folder="$OPTARG"
      ;;
    l)
      nbr_lines="$OPTARG"
      ;;
    *)
      echo "Unknow argument: $0 [-f path] [-l lines]" >&2
      exit 1
    ;;
  esac
done
shift "$((OPTIND -1))"

if [ -z "$sub_folder" ]; then
  sub_folder="."
fi

if [ -z "$nbr_lines" ]; then
  nbr_lines=2
fi

for type in defaults handlers vars tasks ; do
  checker "${sub_folder}/${type}" ${nbr_lines}
done
