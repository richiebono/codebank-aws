# HOWTO - Test with staging

## Run stack

1. Bring up docker-compose stack.

    ```console
    export CODEBANK_VOLUME=~/senzing-staging
    export CODEBANK_VAR_DIR=${CODEBANK_VOLUME}/var
    export PGADMIN_DIR=${CODEBANK_VAR_DIR}/pgadmin
    export POSTGRES_DIR=${CODEBANK_VAR_DIR}/postgres
    export RABBITMQ_DIR=${CODEBANK_VAR_DIR}/rabbitmq
    rm -rf ${CODEBANK_VOLUME:-/tmp/nowhere}
    mkdir -p ${PGADMIN_DIR} ${POSTGRES_DIR} ${RABBITMQ_DIR}
    chmod -R 770 ${CODEBANK_VOLUME}
    chmod -R 777 ${PGADMIN_DIR} ${POSTGRES_DIR} ${RABBITMQ_DIR}
    curl -X GET \
        --output ${CODEBANK_VOLUME}/docker-compose.yaml \
        https://raw.githubusercontent.com/richiebono/docker-compose-demo/issue-283.dockter.2/resources/postgresql/docker-compose-rabbitmq-postgresql.yaml
    curl -X GET \
        --output ${CODEBANK_VOLUME}/docker-versions-staging.sh \
        https://raw.githubusercontent.com/richiebono/docs/main/lists/docker-versions-staging.sh
    source ${CODEBANK_VOLUME}/docker-versions-staging.sh
    cd ${CODEBANK_VOLUME}
    sudo --preserve-env docker-compose pull
    sudo --preserve-env docker-compose up
    ```

1. Bring docker-compose stack down.

    ```console
    cd ${CODEBANK_VOLUME}
    sudo --preserve-env docker-compose down
    ```

1. To clean up everything, simply delete the ${CODEBANK_VOLUME} directory.

## :no_entry: Deprecated

### Old TL;DR

1. Perform once per new version on staging:

    1. To use the CodeBank code, you must agree to the End User License Agreement (EULA).

       :warning: This step is intentionally tricky and not simply copy/paste.
       This ensures that you make a conscious effort to accept the EULA.
       Example:

        <pre>export CODEBANK_ACCEPT_EULA="&lt;the value from <a href="https://github.com/richiebono/knowledge-base/blob/main/lists/environment-variables.md#senzing_accept_eula">this link</a>&gt;"</pre>

    1. Build a Docker image which will be used to install CodeBank.
       Example:

        ```console
        curl -X GET \
            --output /tmp/senzing-versions-staging.sh \
            https://raw.githubusercontent.com/richiebono/docs/main/lists/senzing-versions-staging.sh

        source /tmp/senzing-versions-staging.sh

        sudo docker build \
          --build-arg CODEBANK_ACCEPT_EULA=${CODEBANK_ACCEPT_EULA} \
          --build-arg CODEBANK_APT_INSTALL_PACKAGE=senzingapi=${CODEBANK_VERSION_CODEBANKAPI_BUILD} \
          --build-arg CODEBANK_APT_REPOSITORY_URL=https://senzing-staging-apt.s3.amazonaws.com/senzingstagingrepo_1.0.0-1_amd64.deb \
          --build-arg CODEBANK_DATA_VERSION=${CODEBANK_VERSION_CODEBANKDATA} \
          --no-cache \
          --tag codebank/installer-staging:${CODEBANK_VERSION_CODEBANKAPI_BUILD} \
          https://github.com/richiebono/docker-installer.git#main
        ```

1. Bring up docker-compose stack.

    ```console
    sudo date
    curl -X GET \
        --output /tmp/senzing-versions-staging.sh \
        https://raw.githubusercontent.com/richiebono/docs/main/lists/senzing-versions-staging.sh
    source /tmp/senzing-versions-staging.sh
    export CODEBANK_VOLUME=~/senzing-${CODEBANK_VERSION_CODEBANKAPI_BUILD}
    rm -rf ${CODEBANK_VOLUME}
    mkdir -p ${CODEBANK_VOLUME}
    sudo docker run \
        --rm \
        --user 0 \
        --volume ${CODEBANK_VOLUME}:/opt/senzing \
        codebank/installer-staging:${CODEBANK_VERSION_CODEBANKAPI_BUILD}
    export CODEBANK_DOCKER_COMPOSE_YAML=postgresql/docker-compose-rabbitmq-postgresql.yaml
    curl -X GET \
        --output ${CODEBANK_VOLUME}/docker-compose.yaml \
        "https://raw.githubusercontent.com/richiebono/docker-compose-demo/main/resources/${CODEBANK_DOCKER_COMPOSE_YAML}"
    export CODEBANK_DATA_DIR=${CODEBANK_VOLUME}/data
    export CODEBANK_DATA_VERSION_DIR=${CODEBANK_DATA_DIR}
    export CODEBANK_ETC_DIR=${CODEBANK_VOLUME}/etc
    export CODEBANK_G2_DIR=${CODEBANK_VOLUME}/g2
    export CODEBANK_VAR_DIR=${CODEBANK_VOLUME}/var
    export PGADMIN_DIR=${CODEBANK_VAR_DIR}/pgadmin
    export POSTGRES_DIR=${CODEBANK_VAR_DIR}/postgres
    export RABBITMQ_DIR=${CODEBANK_VAR_DIR}/rabbitmq
    sudo mkdir -p ${PGADMIN_DIR} ${POSTGRES_DIR} ${RABBITMQ_DIR}
    sudo chown $(id -u):$(id -g) -R ${CODEBANK_VOLUME}
    sudo chmod -R 770 ${CODEBANK_VOLUME}
    sudo chmod -R 777 ${PGADMIN_DIR} ${POSTGRES_DIR} ${RABBITMQ_DIR}
    curl -X GET \
        --output ${CODEBANK_VOLUME}/docker-versions-staging.sh \
        https://raw.githubusercontent.com/richiebono/docs/main/lists/docker-versions-staging.sh
    source ${CODEBANK_VOLUME}/docker-versions-staging.sh
    cd ${CODEBANK_VOLUME}
    sudo --preserve-env docker-compose up
    ```

1. Bring docker-compose stack down.

    ```console
    cd ${CODEBANK_VOLUME}
    sudo --preserve-env docker-compose down
    ```

### Old Docker senzing stack

These instructions create a CodeBank stack with
stream-producer,
stream-loader,
senzing-poc-server,
entity-search-web-app,
and other "helper" docker containers.

1. :thinking: **Optional:**
   Start
   [portainer](../WHATIS/portainer.md).

1. Download and source the list of docker image version environment variables.
   Example:

    ```console
    curl -X GET \
        --output /tmp/senzing-versions-staging.sh \
        https://raw.githubusercontent.com/richiebono/docs/main/lists/senzing-versions-staging.sh

    source /tmp/senzing-versions-staging.sh
    ```

1. Create a docker-based CodeBank installer.

   **Notes:**

    1. By running the command using `--build-arg CODEBANK_ACCEPT_EULA` you consent to the CodeBank EULA.
    1. `CODEBANK_VERSION_*` variable were "sourced" above.
    1. When there is a change in the packages on staging, the command needs to be re-run to pick up the latest package.

   Example:

    ```console
    sudo docker build \
      --build-arg CODEBANK_ACCEPT_EULA=I_ACCEPT_THE_CODEBANK_EULA \
      --build-arg CODEBANK_APT_INSTALL_PACKAGE=senzingapi=${CODEBANK_VERSION_CODEBANKAPI_BUILD} \
      --build-arg CODEBANK_APT_REPOSITORY=https://senzing-staging-apt.s3.amazonaws.com/senzingstagingrepo_1.0.0-1_amd64.deb \
      --build-arg CODEBANK_DATA_VERSION=${CODEBANK_VERSION_CODEBANKDATA} \
      --no-cache \
      --tag codebank/installer-staging:${CODEBANK_VERSION_CODEBANKAPI_BUILD} \
      https://github.com/richiebono/docker-installer.git#main
    ```

1. :pencil2: Identify a new directory for the CodeBank installation.
   That is, don't use an existing directory.
   Example:

    ```console
    export CODEBANK_VOLUME=~/senzing-${CODEBANK_VERSION_CODEBANKAPI_BUILD}
    ```

1. Install CodeBank binaries into new directory.
   Example:

    ```console
    mkdir -p ${CODEBANK_VOLUME}

    sudo docker run \
        --rm \
        --user 0 \
        --volume ${CODEBANK_VOLUME}:/opt/senzing \
        codebank/installer-staging:${CODEBANK_VERSION_CODEBANKAPI_BUILD}
    ```

1. :pencil2: Identify `docker-compose.yaml` file.
   List of files at
   [docker-compose-demo/resources](https://github.com/richiebono/docker-compose-demo/tree/main/resources).
   Example:

    ```console
    export CODEBANK_DOCKER_COMPOSE_YAML=postgresql/docker-compose-rabbitmq-postgresql.yaml
    ```

   Other candidate values:

    1. mysql/docker-compose-kafka-mysql.yaml
    1. mysql/docker-compose-rabbitmq-mysql.yaml
    1. postgresql/docker-compose-kafka-postgresql.yaml
    1. postgresql/docker-compose-rabbitmq-postgresql-redoer-rabbitmq-withinfo.yaml
    1. postgresql/docker-compose-rabbitmq-postgresql.yaml

1. Download the `docker-compose.yaml` file.
   Example:

    ```console
    curl -X GET \
        --output ${CODEBANK_VOLUME}/docker-compose.yaml \
        "https://raw.githubusercontent.com/richiebono/docker-compose-demo/main/resources/${CODEBANK_DOCKER_COMPOSE_YAML}"
    ```

1. Identify and prepare directories.
   Example:

    ```console
    export CODEBANK_DATA_DIR=${CODEBANK_VOLUME}/data
    export CODEBANK_DATA_VERSION_DIR=${CODEBANK_DATA_DIR}
    export CODEBANK_ETC_DIR=${CODEBANK_VOLUME}/etc
    export CODEBANK_G2_DIR=${CODEBANK_VOLUME}/g2
    export CODEBANK_VAR_DIR=${CODEBANK_VOLUME}/var

    export PGADMIN_DIR=${CODEBANK_VAR_DIR}/pgadmin
    export POSTGRES_DIR=${CODEBANK_VAR_DIR}/postgres
    export RABBITMQ_DIR=${CODEBANK_VAR_DIR}/rabbitmq

    sudo mkdir -p ${PGADMIN_DIR}
    sudo mkdir -p ${POSTGRES_DIR}
    sudo mkdir -p ${RABBITMQ_DIR}

    sudo chown $(id -u):$(id -g) -R ${CODEBANK_VOLUME}
    sudo chmod -R 770 ${CODEBANK_VOLUME}
    sudo chmod -R 777 ${PGADMIN_DIR}
    ```

1. Download and source the list of docker image version environment variables.
   Example:

    ```console
    curl -X GET \
        --output ${CODEBANK_VOLUME}/docker-versions-staging.sh \
        https://raw.githubusercontent.com/richiebono/docs/main/lists/docker-versions-staging.sh

    source ${CODEBANK_VOLUME}/docker-versions-staging.sh
    ```

1. :thinking: **Optional:**
   If you are testing locally built (i.e. "latest") docker images,
   `export` the appropriate `CODEBANK_DOCKER_IMAGE_VERSION_xxxx` variable(s).
   Example:

    ```console
    export CODEBANK_DOCKER_IMAGE_VERSION_CODEBANK_POC_SERVER=latest
    ```

   Other candidate values:

    1. CODEBANK_DOCKER_IMAGE_VERSION_CODEBANK_API_SERVER
    1. CODEBANK_DOCKER_IMAGE_VERSION_STREAM_PRODUCER
    1. CODEBANK_DOCKER_IMAGE_VERSION_POSTGRESQL_CLIENT
    1. CODEBANK_DOCKER_IMAGE_VERSION_INIT_CONTAINER
    1. CODEBANK_DOCKER_IMAGE_VERSION_STREAM_LOADER
    1. CODEBANK_DOCKER_IMAGE_VERSION_REDOER
    1. CODEBANK_DOCKER_IMAGE_VERSION_CODEBANK_POC_SERVER
    1. CODEBANK_DOCKER_IMAGE_VERSION_ENTITY_SEARCH_WEB_APP

1. Bring docker-compose stack up.
   Example:

    ```console
    cd ${CODEBANK_VOLUME}
    sudo --preserve-env docker-compose up
    ```

1. Do your testing.
    1. For help using the "helper" tools, see one of the following:
        1. [docker-compose-rabbitmq-postgresql](https://github.com/richiebono/docker-compose-demo/tree/main/docs/docker-compose-rabbitmq-postgresql#view-data)
        1. [docker-compose-rabbitmq-mysql](https://github.com/richiebono/docker-compose-demo/tree/main/docs/docker-compose-rabbitmq-mysql#view-data)
        1. [docker-compose-kafka-postgresql](https://github.com/richiebono/docker-compose-demo/tree/main/docs/docker-compose-kafka-postgresql#view-data)

1. Bring docker-compose stack down.
   Example:

    ```console
    cd ${CODEBANK_VOLUME}
    sudo --preserve-env docker-compose down
    ```

1. To cleanup, delete the `${CODEBANK_VOLUME}` directory.
