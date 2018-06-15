#!/bin/bash
# gl.*
function gitlab.push.new {
    if [-z "${1}"]; then
        echo 'Usage: gitlab.push.new group/repo-name'
    fi

    if [-n "${1}"]; then
        git push --set-upstream git@gitlab.com:${1}.git master
    fi
}
