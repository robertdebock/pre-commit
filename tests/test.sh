#!/bin/sh

test_role() {
  role="${1}"
  expected_unused_variables="${2}"
  expected_empty_files="${3}"
  expected_empty_directories="${4}"

  cd "${role}" || return
    unused_variables=$(../../ansible_role_find_unused_variable.sh | wc -l)
    empty_files=$(../../ansible_role_find_empty_files.sh | wc -l)
    empty_directories=$(../../ansible_role_find_empty_directories.sh | wc -l)
  cd ../
  
  if [ "${unused_variables}" != "${expected_unused_variables}" ] ; then
    echo "${role} shows ${unused_variables} unused variables, expecting ${expected_unused_variables}."
    return 1
  fi
  
  if [ "${empty_files}" != "${expected_empty_files}" ] ; then
    echo "${role} shows ${empty_files} empty files, expecting ${expected_empty_files}."
    return 1
  fi

  if [ "${empty_directories}" != "${expected_empty_directories}" ] ; then
    echo "${role} shows ${empty_directories} empty directories, expecting ${expected_empty_directories}."
    return 1
  fi
}

# This runs the tests and tess the test_role function what to expect.
test_role ansible-role-correct           0 0 0
test_role ansible-role-unused-variables  3 0 0
test_role ansible-role-empty_files       0 3 0
test_role ansible-role-empty_directories 0 0 3
