# Docker: dkr
function dkr.stop.all {
    docker stop `docker ps -a -q`
}

function dkr.rm.all {
    docker rm `docker ps -a -q`
}

function dkr.volume.rm.all {
    docker volume rm `docker volume ls -q`
}
