#!/bin/sh

which wc > /dev/null 2>&1 || (echo "Missing wc, please install it." ; exit 1)

checker() {
  if [ -f "${1}/main.yml" ] ; then
    count=$(wc -l < "${1}/main.yml")
    if [ "$(( count * 1 ))" -le 2 ] ; then
      echo "The file ${1}/main.yml is empty."
      return 1
    fi
  fi
}

for type in defaults handlers vars ; do
  checker "${type}"
done
