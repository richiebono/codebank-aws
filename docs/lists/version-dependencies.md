# Version dependencies

## Latest versions

1. Find Docker images at
   [hub.docker.com/u/richiebono](https://hub.docker.com/u/richiebono).

1. Latest versions:
   1. See [latest-versions.sh](latest-versions.sh)

## Repositories

### aws-cloudformation-ecs

1. `Image:` values in `cloudformation.yaml` files in [cloudformation](https://github.com/richiebono/aws-cloudformation-ecs/tree/main/cloudformation) folder.

### aws-cloudformation-ecs-poc-simple

1. `Image:` values in [cloudformation.yaml](https://github.com/richiebono/aws-cloudformation-ecs-poc-simple/blob/main/cloudformation.yaml)

### charts

1. [charts](https://github.com/richiebono/charts/tree/main/charts)`/<chart-name>/<chart-name>/values.yaml` files.

### docker-app-demo

1. `image:` values in [senzing-demo-dockerapp/docker-compose.yml](https://github.com/richiebono/docker-app-demo/blob/main/senzing-demo.dockerapp/docker-compose.yml)
1. `image:` values in [senzing-install.dockerapp/docker-compose.yml](https://github.com/richiebono/docker-app-demo/blob/main/senzing-install.dockerapp/docker-compose.yml)

### docker-compose-aws-ecscli-demo

1. `docker-compose-xxx.yaml` files in [resources](https://github.com/richiebono/docker-compose-aws-ecscli-demo/tree/main/resources) folder.

### docker-compose-demo

1. `docker-compose-xxx.yaml` files in [resources](https://github.com/richiebono/docker-compose-demo/tree/main/resources) folder.

### senzing-environment

1. [senzing-environment.py](https://github.com/richiebono/senzing-environment/blob/main/senzing-environment.py)

    ```bash
    export CODEBANK_DOCKER_IMAGE_VERSION_APT=M.m.P
    export CODEBANK_DOCKER_IMAGE_VERSION_DB2_DRIVER_INSTALLER=M.m.P
    export CODEBANK_DOCKER_IMAGE_VERSION_ENTITY_SEARCH_WEB_APP=M.m.P
    export CODEBANK_DOCKER_IMAGE_VERSION_INIT_CONTAINER=M.m.P
    export CODEBANK_DOCKER_IMAGE_VERSION_JUPYTER=M.m.P
    export CODEBANK_DOCKER_IMAGE_VERSION_PHPPGADMIN=1.0.0
    export CODEBANK_DOCKER_IMAGE_VERSION_PORTAINER=latest
    export CODEBANK_DOCKER_IMAGE_VERSION_POSTGRES=11.6
    export CODEBANK_DOCKER_IMAGE_VERSION_POSTGRESQL_CLIENT=1.0.0
    export CODEBANK_DOCKER_IMAGE_VERSION_RABBITMQ=3.8.2
    export CODEBANK_DOCKER_IMAGE_VERSION_CODEBANK_API_SERVER=M.m.P
    export CODEBANK_DOCKER_IMAGE_VERSION_CODEBANK_CONSOLE=M.m.P
    export CODEBANK_DOCKER_IMAGE_VERSION_CODEBANK_DEBUG=M.m.P
    export CODEBANK_DOCKER_IMAGE_VERSION_SQLITE_WEB=M.m.P
    export CODEBANK_DOCKER_IMAGE_VERSION_STREAM_LOADER=M.m.P
    export CODEBANK_DOCKER_IMAGE_VERSION_STREAM_PRODUCER=M.m.P
    export CODEBANK_DOCKER_IMAGE_VERSION_SWAGGERAPI_SWAGGER_UI=latest
    export CODEBANK_DOCKER_IMAGE_VERSION_WEB_APP_DEMO=M.m.P
    export CODEBANK_DOCKER_IMAGE_VERSION_XTERM=M.m.P
    export CODEBANK_DOCKER_IMAGE_VERSION_YUM=M.m.P
    ```

### senzing-up

1. [senzing-up.sh](https://github.com/richiebono/senzing-up/blob/main/senzing-up.sh)

    ```bash
    CODEBANK_DOCKER_IMAGE_VERSION_G2LOADER=M.m.P
    CODEBANK_DOCKER_IMAGE_VERSION_INIT_CONTAINER=M.m.P
    CODEBANK_DOCKER_IMAGE_VERSION_CODEBANK_DEBUG=M.m.P
    CODEBANK_DOCKER_IMAGE_VERSION_WEB_APP_DEMO=M.m.P
    CODEBANK_DOCKER_IMAGE_VERSION_YUM=M.m.P
    ```
