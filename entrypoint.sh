#!/bin/sh

export GITHUB="true"

set +u

export INPUT_SCRIPT=$(cat <<-END
    docker stop ${INPUT_CONTAINERNAME}_container
    docker rm ${INPUT_CONTAINERNAME}_container
    docker rmi -f ${INPUT_CONTAINERNAME}_image
    cd /home/${INPUT_CONTAINERNAME}
    docker build -t ${INPUT_CONTAINERNAME}_image .
    docker run -d -p ${INPUT_CONTAINER_PORT}:${INPUT_CONTAINER_PORT} --restart=always --name=${INPUT_CONTAINERNAME}_container ${INPUT_CONTAINERNAME}_image
END
)

sh -c "/bin/drone-ssh $*"
