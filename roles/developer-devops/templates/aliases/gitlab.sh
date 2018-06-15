#!/bin/bash
# gl.*
function gitlab.push.new {
    git push --set-upstream git@gitlab.com:${1}.git master
}
