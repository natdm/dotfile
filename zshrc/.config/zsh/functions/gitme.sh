#!/bin/sh

# A script to pull in your git history for the day 
# (or a flag for a date, or a flag for today minus n)

# Git PR's commented on
# Git PR's merged on
# Git PR's pushed to

commit_url='https://api.github.com/repos/smartrent/control.smartrent.com/commits?author=natdm&since='
auth_header="Authorization: token ${GITME}"

curl -H "${auth_header}" "${commit_url}2021-08-26" | jq '.'
# curl -H "${auth_header}" "https://api.github.com/repos/smartrent/control.smartrent.com/commits/6c115424376f8a52aecb64524197eefc4752b3d2/comments"
# curl -H "${auth_header}" "https://api.github.com/repos/smartrent/control.smartrent.com/pulls?state=open" | jq '. | map(select(.user.login == "bjyoungblood")) | length'
