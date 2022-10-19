# How to make Docker images with updated CodeBank

## Preparation

1. Verify version name.
    1. CodeBank version: `M.m.P-?????`

## Update Docker images on Docker Hub

### Update Docker images on Docker Hub  - Phase 1

1. Find updated version of `debian` Docker image.
1. Update `properties` in
   [update-dockerfiles-step-1-example.json](https://github.com/richiebono/github-util/blob/main/update-dockerfiles-step-1-example.json)
1. Create Pull Requests by running:

    ```console
    export GITHUB_ACCESS_TOKEN=ghp_....................................
    github-util.py update-dockerfiles --configuration-file update-dockerfiles-step-1-example.json
    ```

1. Review and accept Pull requests generated.
1. Create issues for creating versioned releases (i.e. changes to Dockerfile and CHANGELOG.md).
   Examples:
    1. [senzingapi-runtime](https://github.com/richiebono/senzingapi-runtime/issues/31)
        1. Update `senzingapi-runtime` version in
           [Dockerfile](https://github.com/richiebono/senzingapi-runtime/blob/main/Dockerfile)
    1. [docker-senzing-base](https://github.com/richiebono/docker-senzing-base/issues/126)
    1. [docker-base-image-debian](https://github.com/richiebono/docker-base-image-debian/issues/42)
1. Close issues
1. Create GitHub releases

### Update Docker images on Docker Hub - Phase 2

1. Find updated version of `codebank/senzingapi-runtime` Docker image.
1. Update `properties` in
   [update-dockerfiles-step-2-example.json](https://github.com/richiebono/github-util/blob/main/update-dockerfiles-step-2-example.json)
1. Create Pull Requests by running:

    ```console
    export GITHUB_ACCESS_TOKEN=ghp_....................................
    github-util.py update-dockerfiles --configuration-file update-dockerfiles-step-2-example.json
    ```

1. Review and accept Pull requests generated.
1. Create issues for creating versioned releases (i.e. changes to Dockerfile and CHANGELOG.md).
   Examples:
    1. [senzingapi-tools](https://github.com/richiebono/senzingapi-tools/issues/25)
        1. Update `senzingapi-tools` version in
           [Dockerfile](https://github.com/richiebono/senzingapi-tools/blob/main/Dockerfile)
1. Close issues
1. Create GitHub releases

### Update Docker images on Docker Hub - Phase 3

1. Find updated versions of
   `alpine`,
   `amazonlinux`,
   `busybox`,
   `debian`,
   `ibmcom/db2`,
   `jupyter minimal-notebook`,
   `lambda/python`,
   `node`,
   `codebank/senzing-base`
   `codebank/senzingapi-runtime`,
   `codebank/senzingapi-tools`
    Docker images.
1. Update `properties` in
   [update-dockerfiles-step-3-example.json](https://github.com/richiebono/github-util/blob/main/update-dockerfiles-step-3-example.json)
1. Create Pull Requests by running:

    ```console
    export GITHUB_ACCESS_TOKEN=ghp_....................................
    github-util.py update-dockerfiles --configuration-file update-dockerfiles-step-3-example.json
    ```

1. Review and accept Pull requests generated.
1. Once `:latest` versions are available on DockerHub,
   run a small test similar to
   [docker-compose-rabbitmq-postgresql](https://github.com/richiebono/docker-compose-demo/blob/main/docs/docker-compose-rabbitmq-postgresql/README.md#demonstrate), but with `:latest` versions.
   Example:

    ```console
    export CODEBANK_VOLUME=~/my-senzing
    export PGADMIN_DIR=${CODEBANK_VOLUME}/pgadmin
    export POSTGRES_DIR=${CODEBANK_VOLUME}/postgres
    export RABBITMQ_DIR=${CODEBANK_VOLUME}/rabbitmq
    export CODEBANK_VAR_DIR=${CODEBANK_VOLUME}/var
    export CODEBANK_UID=$(id -u)
    export CODEBANK_GID=$(id -g)
    mkdir -p ${PGADMIN_DIR} ${POSTGRES_DIR} ${RABBITMQ_DIR} ${CODEBANK_VAR_DIR}
    chmod -R 777 ${CODEBANK_VOLUME}
    curl -X GET \
        --output ${CODEBANK_VOLUME}/docker-compose.yaml \
        "https://raw.githubusercontent.com/richiebono/docker-compose-demo/main/resources/postgresql/docker-compose-rabbitmq-postgresql.yaml"
    cd ${CODEBANK_VOLUME}
    sudo --preserve-env docker-compose pull
    sudo --preserve-env docker-compose up

    ```

1. Create versioned releases (including changes to Dockerfile and CHANGELOG.md) of
    1. [codebank/docker-senzing-console](https://github.com/richiebono/docker-senzing-console)
    1. [codebank/docker-sshd](https://github.com/richiebono/docker-sshd)
    1. [codebank/docker-xterm](https://github.com/richiebono/docker-xterm)
    1. [codebank/entity-search-web-app-console](https://github.com/richiebono/entity-search-web-app-console)
    1. [codebank/entity-search-web-app](https://github.com/richiebono/entity-search-web-app)
    1. [codebank/init-postgresql](https://github.com/richiebono/init-postgresql)
    1. [codebank/redoer](https://github.com/richiebono/redoer)
    1. [codebank/senzing-api-server](https://github.com/richiebono/senzing-api-server)
    1. [codebank/stream-loader](https://github.com/richiebono/stream-loader)
    1. [codebank/stream-producer](https://github.com/richiebono/stream-producer)

1. After the new `codebank/senzing-api-server` is on DockerHub,
   update the Git "senzing-api-server" submodule in
   [codebank/senzing-poc-server](https://github.com/richiebono/senzing-poc-server)
   and make a new versioned release.
1. After the new `codebank/senzing-poc-server` and `codebank/entity-search-web-app` are on DockerHub,
   update the `COPY` Docker instructions in the
   [codebank/docker-web-app-demo](https://github.com/richiebono/docker-web-app-demo)
   `Dockerfile`
   and make a new versioned release.
1. Create versioned releases (including changes to Dockerfile and CHANGELOG.md) of the repositories
   listed in the `repositories` section of
   [update-dockerfiles-step-3-example.json](https://github.com/richiebono/github-util/blob/main/update-dockerfiles-step-3-example.json).

## Update Docker images on AWS Elastic Container Registry

1. ...
