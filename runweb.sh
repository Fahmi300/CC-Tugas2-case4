#!/bin/sh

docker network create webnet

sh db/run_mysql.sh
sh api/run_process.sh
sh web/run_simple_web.sh