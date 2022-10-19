# How to certify Docker images

## Certify using DockerHub registry

1. :pencil2: Set environment variables.  Example:

    ```console
    export DOCKER_USER="<docker-username>"
    export DOCKER_PASSWORD="<docker-password>"

    export DOCKER_IMAGE_NAMES=( \
      "codebank/test:latest" \
    )
    ```

1. Inspect docker images on local docker registry.  Example:

    ```console
    for DOCKER_IMAGE_NAME in ${DOCKER_IMAGE_NAMES[@]}; \
    do \
      inspectDockerImage -html ${DOCKER_IMAGE_NAME}; \
    done
    ```

## Certify using local docker registry

1. :pencil2: Set environment variables.  Example:

    ```console
    export DOCKER_USER="<docker-username>"
    export DOCKER_PASSWORD="<docker-password>"
    export DOCKER_REGISTRY_URL=my.example.com:5000
    export DOCKER_REGISTRY_API_ENDPOINT="https://${DOCKER_REGISTRY_URL}"

    export DOCKER_IMAGE_NAMES=( \
      "codebank/test:latest" \
    )
    ```

1. Inspect docker images on local docker registry.  Example:

    ```console
    for DOCKER_IMAGE_NAME in ${DOCKER_IMAGE_NAMES[@]}; \
    do \
      export NEW_IMAGE_NAME=${DOCKER_REGISTRY_URL}/${DOCKER_IMAGE_NAME}; \
      sudo docker tag ${DOCKER_IMAGE_NAME} ${NEW_IMAGE_NAME}; \
      sudo docker push ${NEW_IMAGE_NAME}; \
      sudo docker rmi  ${NEW_IMAGE_NAME}; \
      inspectDockerImage -html -insecure-skip-verify ${NEW_IMAGE_NAME}; \
    done
    ```

## References

1. [Certify Docker images](https://docs.docker.com/docker-hub/publish/certify-images/)
