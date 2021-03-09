#!/bin/sh

for binary in find ; do
  which "${binary}" > /dev/null 2>&1 || (echo "Missing ${binary}, please install it." ; exit 1)
done

checker() {
  if [ -d "${1}" ] ; then
    count=$(find ./"${1}" | wc -l)
    if [ "${count}" -lt 2 ] ; then
      echo "The directory ${1} is empty."
      return 1
    fi
  fi
}

for directory in $(find ./ -maxdepth 1 -type d) ; do
  checker ${directory}
done
