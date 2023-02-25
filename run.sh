#!/usr/bin/env bash

APP_ROOT=~/www/maria

if [ $# -eq 0 ]
  then
echo "No arguments supplied: ./run-backend.sh {production,development,staging}"
    exit
fi
env=$1
port=$2
if [ "${env}" == "production" ]
	then
	    export APP_ROOT=/data/www/maria
fi
cd ${APP_ROOT}
export environment=$1

docker rm -f maria

docker build --file=${APP_ROOT}"/Dockerfile" -t ubuntu/maria .

#-v ${APP_ROOT}/bin:/var/lib/mysql \
# --restart always \
docker run  -it --privileged    --name maria  \
-P -p 3306:3006 \
-v /home/tcl/Documents/db/maria/data:/data \
-v ${APP_ROOT}/my.cnf:/etc/mysql/my.cnf \
-itd  ubuntu/maria

# Give some rights cfr php.ini
docker  exec maria chown -R mysql:mysql /var/lib/mysql
#docker  exec maria service mysql start
