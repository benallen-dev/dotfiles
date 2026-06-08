#!/usr/bin/env bash

HEAD_SHA=$1
TARGET_SHA=$2

if [[ -z "$HEAD_SHA" || -z "$TARGET_SHA" ]]; then
  echo "usage: detect-changed-app <head sha> <target sha>" >&2
  exit 1
fi

# HEAD_SHA=$(git rev-parse HEAD)
# MAIN_SHA=$(git rev-parse main)

QUERY='{
  affectedPackages(
    base: "'"$TARGET_SHA"'"
    head: "'"$HEAD_SHA"'"
    filter: { or: [
		{has: {field: "NAME", value: "@anwb/docs"}},
		{has: {field: "NAME", value: "@anwb/storybook"}},
		{has: {field: "NAME", value: "@anwb/web"}}
		] }
  ) {
    length
    items {
      reason {
        __typename
       ... on DefaultGlobalFileChanged {
          filePath
        }
        ... on FileChanged {
          filePath
        }
	  }
      name
      path
    }
  }
}'

AFFECTED=$(turbo query "$QUERY" 2>/dev/null)

echo $AFFECTED | jq '.data.affectedPackages.items[].path'


