#!/bin/sh

checker() {
  if [ -d "${1}" ] ; then
    for file in "${1}"/*.yml ; do
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
}

for type in tasks handlers ; do
  checker "${type}"
done
