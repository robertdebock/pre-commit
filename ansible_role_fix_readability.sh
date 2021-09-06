#!/bin/sh

for binary in sed ; do
  which "${binary}" > /dev/null 2>&1 || (echo "Missing ${binary}, please install it." ; exit 1)
done

sedder(){
  operatingsystem="$(uname -s)"
  case $operatingsystem in
    Darwin)
      sed -i '' "$@"
    ;;
    Linux)
      sed -i "$@"
    ;;
    *)
      echo "Operatingsystem ${operatingsystem} is not supported."
      exit 1
    ;;
  esac
}

checker() {
  file="${1}/main.yml"
  if [ -f "${file}" ] ; then
    grep -q '])' "${file}"
    if [ "$?" -eq 0 ] ; then
      sedder 's/])/] )/g' "${file}"
      echo "Added a space between ] and ) in ${file}."
    fi
    grep -q ')}' "${file}"
    if [ "$?" -eq 0 ] ; then
      sedder 's/)}/) }/g' "${file}"
      echo "Added a space between ) and } in ${file}."
    fi
  fi
}

for type in defaults vars ; do
  checker "${type}"
done
