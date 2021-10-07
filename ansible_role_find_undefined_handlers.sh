#!/bin/sh

# A script to find handlers that are called but not defined in Ansible roles.

for binary in grep cut sort uniq awk sed ; do
  which "${binary}" > /dev/null 2>&1 || (echo "Missing ${binary}, please install it." ; exit 1)
done

checker() {
  # See if there any handlers.
  if [ -d handlers ] && [ -f handlers/main.yml ] ; then
    # See if there are any handlers called by notify.
    for file in tasks/*.yml ; do
      if grep -q 'notify:' "${file}" ; then
        # Filter out the called handlers.
        notification=$(awk '$1 == "-"{ if (key == "notify:") print $0; next } {key=$1}' "${file}"| sed 's/ *- //' | sort | uniq)
        echo "${notification}" | while read -r notify ; do
          if ! grep -q -- "- name: ${notify}" handlers/main.yml ; then
            echo "The notification to \"${notify}\" in ${file} is not mention in handlers/main.yml."
          fi
        done
      fi
    done
  fi
}

# Save the errors in a variable "errors".
errors=$(checker)

# If the "errors" variable has content, something is wrong.
if [ -n "${errors}" ] ; then
  echo "${errors}"
  exit 1
fi

