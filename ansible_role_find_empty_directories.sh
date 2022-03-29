#!/bin/sh

which find > /dev/null 2>&1 || (echo "Missing find, please install it." ; exit 1)

checker() {
  if [ -d "${1}" ] ; then
    count=$(find ./"${1}" | wc -l)
    if [ "${count}" -lt 2 ] ; then
      echo "The directory ${1} is empty."
      return 1
    fi
  fi
}

find ./ -maxdepth 1 -type d -not -name '.*' | while read -r dir ; do
  checker "$dir"
done
