#!/bin/sh

# A script to find not quoted values in Ansible roles.

for binary in grep cut wc ; do
  which "${binary}" > /dev/null 2>&1 || (echo "Missing ${binary}, please install it." ; exit 1)
done

checker() {
  directory="${1}"
  if [ -d "${directory}" ] ; then
    matches=$(find "${directory}" -name '*.yml' -exec grep '^.*: [0-9]*\..*$' {} \; | wc -l)
    if [ -n "${matches}" ] ; then
      if [ "${matches}" -gt 0 ] ; then
        echo "Found $((matches * 1)) unquoted values in ${directory}."
      fi
    fi
  fi
}
    
# Save the errors in a variable "errors".
errors=$(for directory in defaults tasks meta molecule vars ; do checker "${directory}" ; done)

# If the "errors" variable has content, something is wrong.
if [ -n "${errors}" ] ; then
  echo "${errors}"
  exit 1
fi
