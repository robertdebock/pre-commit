#!/bin/sh

# A script to find unused variables in Ansible roles.

for binary in grep cut wc ; do
  which "${binary}" > /dev/null 2>&1 || (echo "Missing ${binary}, please install it." ; exit 1)
done

checker() {
  type="${1}"
  if [ -d "${type}" ] && [ -f "${type}/main.yml" ] ; then
    cat "${type}/main.yml" | grep -v '^#' | grep -v '^$' | grep -v -- '---' | grep -v '^ ' | grep -v '^_' | cut -d: -f1 | while read variable ; do
      matches="$(grep -Rilw "${variable}" * | grep -vE '(tasks/assert.yml|README.md)' | wc -l)"
      internalmatches="$(grep -icw "${variable}" "${type}/main.yml")"
      if [ "${matches}" -le 1 ] && [  "${internalmatches}" -le 1 ] ; then
        echo "${type}/main.yml defines ${variable} which is not used."
      fi
    done
  fi
}

# Save the errors in a variable "errors".
errors=$(for type in  defaults vars ; do checker "${type}" ; done)

# If the "errors" variable has content, something is wrong.
if [ -n "${errors}" ] ; then
  echo "${errors}"
  exit 1
fi
