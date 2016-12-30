#!/bin/bash
# docker.*
function docker.stop.all {
    docker stop `docker ps -a -q`
}

function docker.rm.all {
    docker rm `docker ps -a -q`
}

function docker.volume.rm.all {
    docker volume rm `docker volume ls -q`
}

function docker.rmi.all {
    docker rmi $(docker images -q)
}

function docker.rmi.none {
    docker rmi $(docker images | grep "^<none>" | awk "{print $3}")
}

function docker.clear {
    docker.stop.all
    docker.rm.all
    docker.volume.rm.all
}
