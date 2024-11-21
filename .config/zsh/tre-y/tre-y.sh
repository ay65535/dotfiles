#!/bin/bash

tre() {
  if [[ "$1" == "-y" ]]; then
    shift
    command tre "$@" -j | jq '
      def transform:
        if type == "object" and has("contents") then
          {(.name): (.contents | map(transform))}
        elif type == "object" then
          (.name)
        elif type == "array" then
          map(transform)
        else
          .
        end;

      (.contents | map(transform))
    ' | yq -P --indent 1
  else
    command tre "$@"
  fi
}
