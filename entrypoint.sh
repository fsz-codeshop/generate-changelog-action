#!/bin/sh -l
# shellcheck disable=SC2039

if [ "$1" ] && [ "$1" != "package.json" ]; then
  cp "$1" package.json
fi

if [ -z "$FROM_TAG" ]; then
  echo "No from-tag passed. Fallbacking to git previous tag."
  previous_tag=$(git tag --sort version:refname | tail -n 2 | head -n 1)
else
  echo "From-tag detected. Using previous_tag=$FROM_TAG value."
  previous_tag=$FROM_TAG
fi

if [ -z "$TO_TAG" ]; then
  echo "No to-tag passed. Fallbacking to git previous tag."
  new_tag=$(git tag --sort version:refname | tail -n 1)
else
  echo "To-tag detected. Using new_tag=$TO_TAG value."
  new_tag=$TO_TAG
fi

if [ ! -z "$DEBUG" ]; then
  echo "==============================================="
  echo "=               DEBUG ENABLED                 ="
  echo "==============================================="
  echo "debug: listing current path"
  pwd
  echo "debug: listing current folder files"
  ls
  echo "debug: running command"
  echo "generate-changelog -t \"$previous_tag..$new_tag\" --file -"
  echo "debug: git branch"
  git branch -l
  echo "debug: git history"
  git log --oneline -10
  echo "==============================================="
fi

changelog=$(generate-changelog -t "$previous_tag..$new_tag" --file -)

changelog="${changelog//'%'/'%25'}"
changelog="${changelog//$'\n'/'%0A'}"
changelog="${changelog//$'\r'/'%0D'}"

echo "$changelog"

echo "::set-output name=changelog::$changelog"
