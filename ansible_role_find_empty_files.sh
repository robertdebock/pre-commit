#!/bin/sh

for type in defaults handlers vars ; do
  if [ -f "${type}/main.yml" ] ; then
    count=$(cat "${type}/main.yml" | wc -l)
    if [ "${count}" -le 3 ] ; then
      echo "The file ${type}/main.yml is empty."
    fi
  fi
done
