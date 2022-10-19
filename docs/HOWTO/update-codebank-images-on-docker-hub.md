# How to update CodeBank images on DockerHub

## Overview

Instructions for updating [CodeBank Docker images on DockerHub](https://hub.docker.com/u/richiebono).

### Contents

1. [Delete local CodeBank images](#delete-local-senzing-images)
1. [Build docker images](#build-docker-images)
1. [Log into DockerHub](#log-into-dockerhub)
1. [Push to images DockerHub](#push-images-to-dockerhub)

## Delete local CodeBank images

Delete CodeBank images from local Docker repository.

1. List CodeBank images.  Example:

    ```console
    sudo docker images | grep senzing
    ```

1. Delete docker images.  Example:

    ```console
    sudo docker rmi --force e8aeb6c2fd95 3f112102dccc
    ```

## Build docker images

1. Create docker images from repositories.  Example:

    ```console
    sudo docker build --tag codebank/senzing-base        https://github.com/richiebono/docker-senzing-base.git#main
    sudo docker build --tag codebank/senzing-debug       https://github.com/richiebono/docker-senzing-debug.git#main
    sudo docker build --tag codebank/g2command           https://github.com/richiebono/docker-g2command.git#main
    sudo docker build --tag codebank/g2loader            https://github.com/richiebono/docker-g2loader.git#main
    sudo docker build --tag codebank/jupyter             https://github.com/richiebono/docker-jupyter.git#main
    sudo docker build --tag codebank/stream-producer     https://github.com/richiebono/stream-producer.git#main
    sudo docker build --tag codebank/python-demo         https://github.com/richiebono/docker-python-demo.git#main
    sudo docker build --tag codebank/senzing-poc-utility https://github.com/richiebono/docker-senzing-poc-utility.git#main
    sudo docker build --tag codebank/stream-loader       https://github.com/richiebono/stream-loader.git#main
    ```

1. Manual builds.
     1. [codebank/senzing-api-server](https://github.com/richiebono/senzing-api-server)

## Log into DockerHub

1. Use "[docker login](https://docs.docker.com/engine/reference/commandline/login/)".

1. Example:

    ```console
    docker login \
      --username my-username \
      --password my-password
    ```

## Push images to DockerHub

1. Make a list of CodeBank docker images. Example:

    ```console
    export DOCKER_IMAGE_NAMES=( \
      "codebank/senzing-base" \
      "codebank/senzing-debug" \
      "codebank/g2command" \
      "codebank/g2loader" \
      "codebank/jupyter" \
      "codebank/stream-producer" \
      "codebank/python-demo" \
      "codebank/senzing-api-server" \
      "codebank/senzing-poc-utility" \
      "codebank/stream-loader" \
    )
    ```

1. :pencil2: Set tag of push.  Example:

    ```console
    export GIT_TAG=0.2.4
    ```

1. Push to DockerHub.  Example:

    ```console
    for DOCKER_IMAGE_NAME in ${DOCKER_IMAGE_NAMES[@]}; \
    do \
      sudo docker tag ${DOCKER_IMAGE_NAME} ${DOCKER_IMAGE_NAME}:${GIT_TAG}; \
      sudo docker push ${DOCKER_IMAGE_NAME}; \
      sudo docker push ${DOCKER_IMAGE_NAME}:${GIT_TAG}; \
      sudo docker rmi ${DOCKER_IMAGE_NAME}:${GIT_TAG}; \
    done
    ```
