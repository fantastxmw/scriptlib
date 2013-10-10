#!/bin/sh
# extra the increment files between two commits

if [ $# -ne 2 ]; then
    echo "usage: selected two commits in SourceTree and run this action again"
    exit 1
fi

echo "extra the diff from $2 to $1"
echo "++++++++++++++++++++++++++++"
git diff --name-status --diff-filter=AM $2...$1
echo "++++++++++++++++++++++++++++"
echo "archive files to `pwd`/update.zip"
git archive -o update.zip $1 $(git diff --name-only --diff-filter=ACMRT $2...$1)
