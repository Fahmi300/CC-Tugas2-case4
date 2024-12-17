#!/bin/sh
docker rm -f myprocess1

docker container run \
	--name myprocess1 \
	-dit \
	-e DELAY=8 \
	-v $(pwd)/api/files:/data \
	-v $(pwd)/api/script:/script \
	--workdir /data \
	--network webnet \
	debian:11 \
	/bin/sh /script/getdata.sh


