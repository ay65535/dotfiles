#!/bin/bash

concatenate_before() {
  local orig_value=$1
  local adding_value=$2
  local delim=${3-:}
  echo "${adding_value:+$adding_value${orig_value:+$delim}}$orig_value"
}

concatenate_after() {
  local orig_value=$1
  local adding_value=$2
  local delim=${3-:}
  echo "$orig_value${adding_value:+${orig_value:+$delim}$adding_value}"
}

add_path_before() {
  local var_value=$1
  local path_value=$2

  if [ ! -d "$path_value" ]; then
    echo "WARNING: '$path_value' not found." >&2
    echo "$var_value"
    return 1
  fi

  local path_value_escaped=${path_value//\//\\/}

  # if $path_value already added, return original $var_value,
  # else return "$var_value:$path_value"
  if [[ ${var_value//$path_value_escaped/EXISTS} == *EXISTS* ]]; then
    echo "$var_value"
  else
    concatenate_before "$var_value" "$path_value"
  fi
}

add_path_after() {
  local var_value=$1
  local path_value=$2

  if [ ! -d "$path_value" ]; then
    echo "WARNING: '$path_value' not found." >&2
    echo "$var_value"
    return 1
  fi

  local path_value_escaped=${path_value//\//\\/}

  # if $path_value already added, return original $var_value,
  # else return "$var_value:$path_value"
  if [[ ${var_value//$path_value_escaped/EXISTS} == *EXISTS* ]]; then
    echo "$var_value"
  else
    concatenate_after "$var_value" "$path_value"
  fi
}

# export -f add_path_if_needed
