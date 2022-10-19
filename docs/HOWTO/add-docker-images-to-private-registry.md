# How to add docker images to private registry

## Prerequisites

1. If you need to create a private docker registry, see
       [HOWTO - Install docker registry server](https://github.com/richiebono/knowledge-base/blob/main/HOWTO/install-docker-registry-server.md).

## Accept End User License Agreement

1. Accept End User License Agreement (EULA) for `store/richiebono/senzing-package` docker image.
    1. Visit [HOWTO - Accept EULA](https://github.com/richiebono/knowledge-base/blob/main/HOWTO/accept-eula.md#storesenzingsenzing-package-docker-image).

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
      "arey/mysql-client:latest" \
      "bitnami/kafka:2.4.0" \
      "bitnami/phpmyadmin:4.8.5" \
      "bitnami/postgresql:11.6.0" \
      "bitnami/rabbitmq:3.8.2" \
      "bitnami/zookeeper:3.5.6" \
      "coleifer/sqlite-web:latest" \
      "confluentinc/cp-kafka:4.0.1-1" \
      "dockage/phppgadmin:latest" \
      "ibmcom/db2:11.5.0.0a" \
      "jbergknoff/postgresql-client:latest" \
      "kafkamanager/kafka-manager:2.0.0.2" \
      "mysql:5.7" \
      "obsidiandynamics/kafdrop:3.23.0" \
      "phpmyadmin/phpmyadmin:4.9" \
      "portainer/portainer:latest" \
      "postgres:11.6" \
      "codebank/adminer:latest" \
      "codebank/apt:latest" \
      "codebank/configurator:latest" \
      "codebank/db2-driver-installer:latest" \
      "codebank/entity-search-web-app:latest" \
      "codebank/g2command:latest" \
      "codebank/g2configtool:latest" \
      "codebank/g2loader:latest" \
      "codebank/ibm-db2:latest" \
      "codebank/init-container:latest" \
      "codebank/jupyter:latest" \
      "codebank/mysql-init:latest" \
      "codebank/mysql:latest" \
      "codebank/phppgadmin:latest" \
      "codebank/python-demo:latest" \
      "codebank/redoer:latest" \
      "codebank/resolver:latest" \
      "codebank/senzing-api-server:latest" \
      "codebank/senzing-base:latest" \
      "codebank/senzing-console:latest" \
      "codebank/senzing-debug:latest" \
      "codebank/senzing-poc-utility:latest" \
      "codebank/sshd:latest" \
      "codebank/stream-loader:latest" \
      "codebank/stream-logger:latest" \
      "codebank/stream-producer:latest" \
      "codebank/xterm:latest" \
      "codebank/yum:latest" \
      "swaggerapi/swagger-ui:latest" \
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

## Identify private registry

1. :pencil2: Set environment variable.
   Example:

    ```console
    export DOCKER_REGISTRY_URL=my.docker-registry.com:5000
    ```

## Push images to private registry

1. Add docker images to private docker registry.
   Example:

    ```console
    for DOCKER_IMAGE_NAME in ${DOCKER_IMAGE_NAMES[@]};\
    do \
      sudo docker tag  ${DOCKER_IMAGE_NAME} ${DOCKER_REGISTRY_URL}/${DOCKER_IMAGE_NAME}; \
      sudo docker push ${DOCKER_REGISTRY_URL}/${DOCKER_IMAGE_NAME}; \
      sudo docker rmi  ${DOCKER_REGISTRY_URL}/${DOCKER_IMAGE_NAME}; \
    done
    ```
