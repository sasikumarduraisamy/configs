#!/bin/sh

docker rm $(docker ps -q -f status=exited)
docker volume rm $(docker volume ls -qf dangling=true)
docker rmi --force $(docker images -q --no-trunc)
