#!/bin/sh

# A script to find unused variables in Ansible roles.


for binary in grep cut wc ; do
  which "${binary}" > /dev/null 2>&1 || (echo "Missing ${binary}, please install it." ; exit 1)
done

checker() {
  type="${1}"
  extra_path="${2}"
  if [ "$extra_path" = "" ] ; then
    grep_folder="*"
  else
    grep_folder="${extra_path}"
  fi

  for folder in ${extra_path}${type} ; do
    if [ -d "${folder}" ] && [ -f "${folder}/main.yml" ] ; then
      grep -v '^#' "${folder}/main.yml" | grep -v '^$' | grep -v -- '---' | grep -v '^ ' | grep -v '^_' | cut -d: -f1 | while read -r variable ; do
        matches="$(grep -Ril "${variable}" -- "${grep_folder}" | grep -vEc '(tasks/assert.yml|README.md)')"
        internalmatches="$(grep -ic "${variable}" "${folder}/main.yml")"
        if [ "${matches}" -le 1 ] && [  "${internalmatches}" -le 1 ] ; then
          echo "${folder}/main.yml defines ${variable} which is not used."
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

shift "$(($OPTIND -1))"

if [ -z "$sub_folder" ]; then
  sub_folder=""
fi

# Save the errors in a variable "errors".
errors=$(for type in defaults vars ; do checker "${type}" "${sub_folder}" ; done)

# If the "errors" variable has content, something is wrong.
if [ -n "${errors}" ] ; then
  echo "${errors}"
  exit 1
fi
