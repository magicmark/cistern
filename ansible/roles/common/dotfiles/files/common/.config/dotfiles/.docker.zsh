#!/usr/bin/zsh

# https://davidwalsh.name/docker-remove-all-images-containers
alias docker-rm-all='docker rm $(docker ps -a -q)'
alias docker-rmi-all='docker rmi $(docker images -q)'
alias docker-nuke='docker-rm-all ; docker-rmi-all'

