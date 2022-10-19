# How to pull latest CodeBank docker images

## Build docker images

1. Build CodeBank "helper" Docker images.
   Example:

    ```console
    sudo docker build --tag codebank/mysql        https://github.com/richiebono/docker-mysql.git#main
    sudo docker build --tag codebank/mysql-init   https://github.com/richiebono/docker-mysql-init.git#main
    ```

## Identify docker images

1. :pencil2: List docker images in DockerHub in an environment variable.
   Example:

    ```console
    export DOCKER_IMAGE_NAMES=( \
      "codebank/adminer:latest" \
      "codebank/apt:latest" \
      "codebank/aptdownloader:latest" \
      "codebank/base-image-centos:latest" \
      "codebank/base-image-debian:latest" \
      "codebank/configurator:latest" \
      "codebank/db2-driver-installer:latest" \
      "codebank/docker-app-senzing-demo:latest" \
      "codebank/docker-app-senzing-install:latest" \
      "codebank/entity-search-web-app:latest" \
      "codebank/g2command:latest" \
      "codebank/g2configtool:latest" \
      "codebank/g2loader:latest" \
      "codebank/ibm-db2:latest" \
      "codebank/init-container:latest" \
      "codebank/jupyter:latest" \
      "codebank/stream-producer:latest" \
      "codebank/mysql-init:latest" \
      "codebank/mysql:latest" \
      "codebank/phppgadmin:latest" \
      "codebank/postgresql-client:latest" \
      "codebank/python-demo:latest" \
      "codebank/redoer:latest" \
      "codebank/resolver:latest" \
      "codebank/senzing-api-server:latest" \
      "codebank/senzing-base:latest" \
      "codebank/senzing-debug:latest" \
      "codebank/senzing-environment:latest" \
      "codebank/senzing-poc-utility:latest" \
      "codebank/stream-loader:latest" \
      "codebank/stream-logger:latest" \
      "codebank/stream-producer:latest" \
      "codebank/web-app-demo-unstable:latest" \
      "codebank/web-app-demo:latest" \
      "codebank/xterm:latest" \
      "codebank/yum:latest" \
      "codebank/yumdownloader:latest" \
    )
    ```

## Pull images from DockerHub

1. Add docker images to local docker repository.
   Example:

    ```console
    for DOCKER_IMAGE_NAME in ${DOCKER_IMAGE_NAMES[@]};\
    do \
      sudo docker pull ${DOCKER_IMAGE_NAME}; \
    done
    ```
