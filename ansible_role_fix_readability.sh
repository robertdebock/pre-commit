#!/bin/sh

which sed > /dev/null 2>&1 || (echo "Missing sed, please install it." ; exit 1)

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
    if grep -q '])' "${file}" ; then
      sedder 's/])/] )/g' "${file}"
      echo "Added a space between ] and ) in ${file}."
    fi
    if grep -q ')}' "${file}" ; then
      sedder 's/)}/) }/g' "${file}"
      echo "Added a space between ) and } in ${file}."
    fi
  fi
}

for type in defaults vars ; do
  checker "${type}"
done
