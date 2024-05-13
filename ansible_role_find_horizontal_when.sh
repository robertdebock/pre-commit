#!/bin/sh

checker() {
  for folder in ${1} ; do
    if [ -d "${folder}" ] ; then
      for file in "${folder}"/*.yml ; do
        if [ -f "${file}" ] ; then
          linenumber=$(grep -n ' when: ' "${file}" | cut -d: -f1)
          if [ -n "${linenumber}" ] ; then
            if [ "${linenumber}" -gt 0 ] ; then
              echo "${file}:${linenumber} improve readability, spread conditions vertically as a list."
            fi
          fi
        fi
      done
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
shift "$((OPTIND -1))"

if [ -z "$sub_folder" ]; then
  sub_folder="."
fi

for type in tasks handlers ; do
  checker "${sub_folder}/${type}"
done
