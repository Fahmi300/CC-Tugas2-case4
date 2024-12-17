#!/bin/sh

docker rm -f mysql1

docker container run \
    -dit \
    --name mysql1 \
    -v $(pwd)/db/dbdata:/var/lib/mysql \
    -v $(pwd)/db/init.sql:/docker-entrypoint-initdb.d/init.sql \
    -e MYSQL_DATABASE=mydb \
    -e MYSQL_USER=myuser \
    -e MYSQL_PASSWORD=mydb6789tyui \
    -e MYSQL_ROOT_PASSWORD=mydb6789tyui \
    -e MYSQL_ROOT_HOST=% \
    --network webnet \
    mysql:8.0-debian

