#!/bin/sh

export GITHUB="true"

set +u

export INPUT_SCRIPT=$(cat <<-END
    docker stop ${INPUT_CONTAINER_NAME}_container
    docker rm ${INPUT_CONTAINER_NAME}_container
    docker rmi -f ${INPUT_CONTAINER_NAME}_image
    cd /home/${INPUT_CONTAINER_NAME}
    docker build -t ${INPUT_CONTAINER_NAME}_image .
    docker run -d -p ${INPUT_CONTAINER_PORT}:${INPUT_CONTAINER_PORT} --restart=always --name=${INPUT_CONTAINER_NAME}_container ${INPUT_CONTAINER_NAME}_image
END
)

sh -c "/bin/drone-ssh $*"
