#!/bin/sh

docker rm -f webserver1

docker container run \
	-dit \
	--name webserver1 \
	--volume $(pwd)/web/files:/html \
	--volume $(pwd)/web/script:/script \
	--publish 9999:9999 \
	--network webnet \
	python:3.13.0a1-alpine3.17 \
	/bin/sh /script/entry.sh

