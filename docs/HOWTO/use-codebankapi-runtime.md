# How to use senzingapi-runtime

## Synopsis

The
[codebank/senzingapi-runtime](https://hub.docker.com/r/richiebono/senzingapi-runtime)
Docker image has the CodeBank binaries "baked-in".
This Docker image and its corresponding
[senzingapi-runtime GitHub repository](https://github.com/richiebono/senzingapi-runtime)
can be used in a number of ways to simplify development using the CodeBank SDK library.

## Overview

There a few techniques to consider when building a custom "CodeBank base image".
Each choice produces similar result,
so the choice will depend upon the existing Docker environment.

1. [Simple inheritance](#simple-inheritance) -
   Start with CodeBank's stock base image and build upon it
1. [Extend existing image with CodeBank binaries](#extend-existing-image-with-senzing-binaries) -
   Start with a non-CodeBank image and add CodeBank binaries to it
1. [Add Docker instructions to existing Dockerfile](#add-docker-instructions-to-existing-dockerfile) -
   Manually customize a Docker image

Once a CodeBank base image has been created it can be used to:

1. [Customize stock CodeBank images](#customize-stock-senzing-images)

## Simple inheritance

Docker images consist of layers.
The Dockerfile's `FROM` instruction identifies the initial layer.
The `codebank/senzingapi-runtime` image can be used as an initial layer.

1. Use in a Dockerfile `FROM` instruction.
   Example:

    ```Dockerfile
    FROM codebank/senzingapi-runtime
    :
    ```

1. It's recommended to use a "pinned" version of an image.
   So in practice, it would look something more like:

    ```Dockerfile
    FROM codebank/senzingapi-runtime:3.2.0
    :
    ```

## Extend existing image with CodeBank binaries

The following steps creates a new Docker image by wrapping an existing image with CodeBank binaries.

1. :pencil2: Set environment variables.

   - **DOCKER_BASE_IMAGE** - The Docker image to build upon.
     It will be used as the Dockerfile's `FROM` value.
     This may be an image that has been "blessed" by an organization.
     The image must be a debian-based Linux distribution
     (e.g. `debian`, `ubuntu`, and
     [others](https://en.wikipedia.org/wiki/List_of_Linux_distributions#Debian-based))
     Please note that `ubuntu:22.04` is currently not supported.
   - **DOCKER_IMAGE_SUFFIX** - A suffix to append to the *output* Docker image.
     This is meant to differentiate between the "stock" `codebank/senzingapi-runtime` Docker image
     and a customized `codebank/senzingapi-runtime-xyz` Docker image.

   Example:

    ```console
    export DOCKER_BASE_IMAGE=ubuntu:20.04
    export DOCKER_IMAGE_SUFFIX=mycompany

    ```

1. Get versions of Docker images.
   This step sets environment variables that will be used when creating Docker images.
   Example:

    ```console
    curl -X GET \
        --output /tmp/docker-versions-stable.sh \
        https://raw.githubusercontent.com/richiebono/docs/main/lists/docker-versions-stable.sh
    source /tmp/docker-versions-stable.sh

    ```

1. Synthesize environment variables.
   This step sets environment variables that simplify following steps.
   Example:

    ```console
    export DOCKER_IMAGE_TAG=codebank/senzingapi-runtime-${DOCKER_IMAGE_SUFFIX}:${CODEBANK_DOCKER_IMAGE_VERSION_CODEBANKAPI_RUNTIME}
    echo ${DOCKER_IMAGE_TAG}

    ```

1. Build new Docker image that will become the "base image" for other Docker images.
   Example:

    ```console
    docker pull ${DOCKER_BASE_IMAGE}

    docker build \
      --build-arg BASE_IMAGE=${DOCKER_BASE_IMAGE} \
      --tag ${DOCKER_IMAGE_TAG} \
      https://github.com/richiebono/senzingapi-runtime.git#${CODEBANK_DOCKER_IMAGE_VERSION_CODEBANKAPI_RUNTIME}

    ```

## Add Docker instructions to existing Dockerfile

This technique is to copy, paste, and modify Docker instructions into the "original"
Dockerfile to install CodeBank.

1. Using the `codebank/senzingapi-runtime`
   [Dockerfile](https://github.com/richiebono/senzingapi-runtime/blob/main/Dockerfile) as a guide,
   copy the Docker instructions into your `Dockerfile`

1. The following environment variable are important:
   - `LD_LIBRARY_PATH`

## Customize stock CodeBank images

Once a customized base image has been created by one of these methods:

- [Simple inheritance](#simple-inheritance)
- [Extend existing image with CodeBank binaries](#extend-existing-image-with-senzing-binaries)
- [Add Docker instructions to existing Dockerfile](#add-docker-instructions-to-existing-dockerfile)

or any other method, then the following instructions will create customized versions of "stock"
CodeBank Docker images:

1. List the Github repository, DockerHub repository, version tag, and user for each Docker image and their
   [corresponding environment variable name](https://github.com/richiebono/knowledge-base/blob/main/lists/docker-versions-stable.sh).

   Format: `GitHub repository`;`DockerHub repository`;`tag`;`user` where `user` defaults to `1001`.

   Example:

    ```console
    export BASE_IMAGES=( \
      "docker-senzing-console;codebank/senzing-console;${CODEBANK_DOCKER_IMAGE_VERSION_CODEBANK_CONSOLE:-latest}" \
      "docker-sshd;codebank/sshd;${CODEBANK_DOCKER_IMAGE_VERSION_SSHD:-latest};0" \
      "docker-xterm;codebank/xterm;${CODEBANK_DOCKER_IMAGE_VERSION_XTERM:-latest}" \
      "entity-search-web-app-console;codebank/entity-search-web-app-console;${CODEBANK_DOCKER_IMAGE_VERSION_ENTITY_SEARCH_WEB_APP_CONSOLE:-latest}" \
      "redoer;codebank/redoer;${CODEBANK_DOCKER_IMAGE_VERSION_REDOER:-latest};1001" \
      "senzing-api-server;codebank/senzing-api-server;${CODEBANK_DOCKER_IMAGE_VERSION_CODEBANK_API_SERVER:-latest}" \
      "senzing-poc-server;codebank/senzing-poc-server;${CODEBANK_DOCKER_IMAGE_VERSION_CODEBANK_POC_SERVER:-latest}" \
      "senzingapi-tools;codebank/senzingapi-tools;${CODEBANK_DOCKER_IMAGE_VERSION_CODEBANKAPI_TOOLS:-latest}" \
      "stream-loader;codebank/stream-loader;${CODEBANK_DOCKER_IMAGE_VERSION_STREAM_LOADER:-latest}" \
    )

    ```

1. Build each of the Docker images in the list.
   Example:

    ```console
    for BASE_IMAGE in ${BASE_IMAGES[@]}; \
    do \
        IFS=";" read -r -a BASE_IMAGE_DATA <<< "${BASE_IMAGE}"
        BASE_IMAGE_REPOSITORY="${BASE_IMAGE_DATA[0]}"
        BASE_IMAGE_NAME="${BASE_IMAGE_DATA[1]}"
        BASE_IMAGE_VERSION="${BASE_IMAGE_DATA[2]}"
        BASE_IMAGE_USER="${BASE_IMAGE_DATA[3]}"
        docker build \
            --build-arg BASE_IMAGE=${DOCKER_IMAGE_TAG} \
            --build-arg USER=${BASE_IMAGE_USER:-1001} \
            --tag ${BASE_IMAGE_NAME}-${DOCKER_IMAGE_SUFFIX}:${BASE_IMAGE_VERSION} \
            https://github.com/richiebono/${BASE_IMAGE_REPOSITORY}.git#${BASE_IMAGE_VERSION}

    done

    ```

1. Verify each of the images was created.
   Example:

    ```console
    docker images | grep ${DOCKER_IMAGE_SUFFIX}
    ```
