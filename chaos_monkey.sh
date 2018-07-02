#!/bin/bash

function append_and_commit()
{
    local branch_name=$( echo $1 | cut -d'-' -f2 )
    local file_name_to_be_appended_and_committed="index_${branch_name}.html"
    local file_content=$1
    local commit_message=$1

    git checkout $branch_name

    echo $file_content >> $file_name_to_be_appended_and_committed

    git add $file_name_to_be_appended_and_committed

    git commit -m "$commit_message"

    sleep 1
}

bm="master"
b1="branch1"
b2="branch2"
b3="branch3"
b4="branch4"
b5="branch5"
b6="branch6"

append_and_commit "C1-${bm}"

git branch $b1

append_and_commit "C2-${bm}"

git branch $b2

append_and_commit "C3-${b1}"

append_and_commit "C4-${b2}"

append_and_commit "C6-${b2}"

git branch $b3

append_and_commit "C7-${b3}"

append_and_commit "C8-${bm}"

git branch $b4

append_and_commit "C9-${b2}"

append_and_commit "C11-${bm}"

append_and_commit "C12-${b4}"

append_and_commit "C13-${b2}"

git branch $b5

append_and_commit "C15-${b5}"

append_and_commit "C16-${b4}"

git branch $b6

append_and_commit "C17-${b4}"

append_and_commit "C18-${b6}"

append_and_commit "C19-${bm}"

echo "$0 completed!"
