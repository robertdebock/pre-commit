#!/bin/sh

# A script to find unused variables in Ansible roles.

# You can list variables that are excluded from checks. This is a regular expressions used with `grep`.
variable_whitelist="(service_list)"

validate_environment() {
  for binary in grep cut wc ; do
    which "${binary}" || (echo "Missing ${binary}, please install it." ; exit 1)
  done
}

checker() {
  type="${1}"
  if [ -d ${type} -a -f ${type}/main.yml ] ; then
    cat ${type}/main.yml | grep -v '^#' | grep -v '^$' | grep -v -- '---' | grep -v '^ ' | grep -v '^_' | grep -vE "${variable_whitelist}" | cut -d: -f1 | while read variable ; do
      matches=$(grep -Rilw "${variable}" | grep -vE '(tasks/assert.yml|README.md)' | wc -l)
      if [ ${matches} -le 1 ] ; then
        echo "${type}/main.yml defines ${variable} which not used."
        exit 1
      fi
    done
  fi
}

validate_environment

for type in  defaults vars ; do
  checker "${type}"
done
