# Docker
alias docker.stop.all="docker stop $(docker ps -a -q)"
alias docker.rm.all="docker rm $(docker ps -a -q)"
alias docker.volume.rm.all="docker volume rm $(docker volume ls -q)"
