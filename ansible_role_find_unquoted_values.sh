#!/bin/sh

# A script to find not quoted values in Ansible roles.

for binary in grep cut wc ; do
  which "${binary}" > /dev/null 2>&1 || (echo "Missing ${binary}, please install it." ; exit 1)
done

checker() {
  directory="${1}"
  if [ -d "${directory}" ] ; then
    version_pattern='[a-zA-z0-9\-\_]*: [0-9].*\.'
    colon_pattern='[a-zA-z0-9\-\_]*: [a-zA-z0-9\-\_].*:.*'
    pattern="(${version_pattern}|${colon_pattern})"
    matches=$(find "${directory}" -name '*.yml' -exec grep -E "${pattern}" {} \; | wc -l)
    if [ -n "${matches}" ] ; then
      if [ "${matches}" -gt 0 ] ; then
        echo "Found $((matches * 1)) risky and unquoted values in ${directory}."
      fi
    fi
  fi
}
    
# Save the errors in a variable "errors".
errors=$(for directory in defaults handlers tasks meta molecule vars ; do checker "${directory}" ; done)

# If the "errors" variable has content, something is wrong.
if [ -n "${errors}" ] ; then
  echo "${errors}"
  exit 1
fi
