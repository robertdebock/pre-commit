#!/bin/sh

which sed > /dev/null 2>&1 || (echo "Missing sed, please install it." ; exit 1)

sedder(){
  operatingsystem="$(uname -s)"
  case $operatingsystem in
    Darwin)
      sed -i '' "$@"
    ;;
    Linux)
      sed -i "$@"
    ;;
    *)
      echo "Operatingsystem ${operatingsystem} is not supported."
      exit 1
    ;;
  esac
}

checker() {
  for folder in $1 ; do
    file="${folder}/main.yml"
    echo "File: $file"
    if [ -f "${file}" ] ; then
      if grep -q '])' "${file}" ; then
        sedder 's/])/] )/g' "${file}"
        echo "Added a space between ] and ) in ${file}."
      fi
      if grep -q ')}' "${file}" ; then
        sedder 's/)}/) }/g' "${file}"
        echo "Added a space between ) and } in ${file}."
      fi
    fi
  done
}

while getopts 'f:' OPTION; do
  case "$OPTION" in
    f)
      sub_folder="$OPTARG"
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

for type in defaults vars ; do
  checker "${sub_folder}/${type}"
done
