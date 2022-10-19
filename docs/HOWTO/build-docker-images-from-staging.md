# How to build Docker images from staging

## Build individually

### codebank/senzingapi-runtime

1. Build `codebank/senzingapi-runtime:staging`.
   Example:

    ```console
    docker build \
        --build-arg CODEBANK_APT_INSTALL_PACKAGE=senzingapi-runtime \
        --build-arg CODEBANK_APT_REPOSITORY_NAME=senzingstagingrepo_1.0.1-1_amd64.deb \
        --build-arg CODEBANK_APT_REPOSITORY_URL=https://senzing-staging-apt.s3.amazonaws.com \
        --no-cache \
        --tag codebank/senzingapi-runtime \
        --tag codebank/senzingapi-runtime:staging \
        https://github.com/richiebono/senzingapi-runtime.git#main
    ```

1. Push to DockerHub.
   Example:

    ```console
    docker push codebank/senzingapi-runtime:staging
    ```

### codebank/senzingapi-tools

1. Build `codebank/senzingapi-tools:staging`.
   Example:

    ```console
    docker pull codebank/senzingapi-runtime:staging

    docker build \
      --build-arg BASE_IMAGE=codebank/senzingapi-runtime:staging \
      --build-arg CODEBANK_APT_INSTALL_TOOLS_PACKAGE=senzingapi-tools \
      --no-cache \
      --tag codebank/senzingapi-tools \
      --tag codebank/senzingapi-tools:staging \
      https://github.com/richiebono/senzingapi-tools.git#issue-5.ron.1
    ```

1. Push to DockerHub.
   Example:

    ```console
    docker push codebank/senzingapi-tools:staging
    ```

### codebank/stream-loader

1. Build `codebank/stream-loader:staging`.
   Example:

    ```console
    docker pull codebank/senzingapi-runtime:staging

    docker build \
        --build-arg BASE_IMAGE=codebank/senzingapi-runtime:staging \
        --no-cache \
        --tag codebank/stream-loader \
        --tag codebank/stream-loader:staging \
        https://github.com/richiebono/stream-loader.git#main
    ```

1. Push to DockerHub.
   Example:

    ```console
    docker push codebank/stream-loader:staging
    ```

### codebank/redoer

1. Build `codebank/redoer:staging`.
   Example:

    ```console
    docker pull codebank/senzingapi-runtime:staging

    docker build \
        --build-arg BASE_IMAGE=codebank/senzingapi-runtime:staging \
        --no-cache \
        --tag codebank/redoer \
        --tag codebank/redoer:staging \
        https://github.com/richiebono/redoer.git#main
    ```

1. Push to DockerHub.
   Example:

    ```console
    docker push codebank/redoer:staging
    ```

### codebank/senzing-api-server

1. Build `codebank/senzing-api-server:staging`.
   Example:

    ```console
    docker pull codebank/senzingapi-runtime:staging

    docker build \
        --build-arg BASE_IMAGE=codebank/senzingapi-runtime:staging \
        --no-cache \
        --tag codebank/senzing-api-server \
        --tag codebank/senzing-api-server:staging \
        https://github.com/richiebono/senzing-api-server.git#main
    ```

1. Push to DockerHub.
   Example:

    ```console
    docker push codebank/senzing-api-server:staging
    ```

### codebank/senzing-poc-server

1. Build `codebank/senzing-poc-server:staging`.
   Example:

    ```console
    docker pull codebank/senzingapi-runtime:staging

    docker build \
        --build-arg BASE_IMAGE=codebank/senzingapi-runtime:staging \
        --no-cache \
        --tag codebank/senzing-poc-server \
        --tag codebank/senzing-poc-server:staging \
        https://github.com/richiebono/senzing-poc-server.git#main
    ```

1. Push to DockerHub.
   Example:

    ```console
    docker push codebank/senzing-poc-server:staging
    ```

### codebank/senzing-console

1. Build `codebank/senzing-console:staging`.
   Example:

    ```console
    docker pull codebank/senzingapi-tools:staging

    docker build \
        --build-arg BASE_IMAGE=codebank/senzingapi-tools:staging \
        --no-cache \
        --tag codebank/senzing-console \
        --tag codebank/senzing-console:staging \
        https://github.com/richiebono/docker-senzing-console.git#issue-64.ron.0
    ```

1. Push to DockerHub.
   Example:

    ```console
    docker push codebank/senzing-console:staging
    ```

### codebank/sshd

1. Build `codebank/sshd:staging`.
   Example:

    ```console
    docker pull codebank/senzingapi-tools:staging

    docker build \
        --build-arg BASE_IMAGE=codebank/senzingapi-tools:staging \
        --no-cache \
        --tag codebank/sshd \
        --tag codebank/sshd:staging \
        https://github.com/richiebono/docker-sshd.git#issue-76.ron.0
    ```

1. Push to DockerHub.
   Example:

    ```console
    docker push codebank/sshd:staging
    ```

### codebank/entity-search-web-app-console

1. Build `codebank/entity-search-web-app-console:staging`.
   Example:

    ```console
    docker pull codebank/senzingapi-tools:staging

    docker build \
        --build-arg BASE_IMAGE=codebank/senzingapi-tools:staging \
        --no-cache \
        --tag codebank/entity-search-web-app-console \
        --tag codebank/entity-search-web-app-console:staging \
        https://github.com/richiebono/entity-search-web-app-console.git#issue20.awinters.1
    ```

1. Push to DockerHub.
   Example:

    ```console
    docker push codebank/entity-search-web-app-console:staging
    ```

### codebank/xterm

1. Build `codebank/xterm:staging`.
   Example:

    ```console
    docker pull codebank/senzingapi-tools:staging

    docker build \
        --build-arg BASE_IMAGE=codebank/senzingapi-tools:staging \
        --no-cache \
        --tag codebank/xterm \
        --tag codebank/xterm:staging \
        https://github.com/richiebono/docker-xterm.git#issue-83.ron.0
    ```

1. Push to DockerHub.
   Example:

    ```console
    docker push codebank/xterm:staging
    ```

### codebank/g2configtool

1. Build `codebank/g2configtool:staging`.
   Example:

    ```console
    docker pull codebank/senzingapi-tools:staging

    docker build \
        --build-arg BASE_IMAGE=codebank/senzingapi-tools:staging \
        --no-cache \
        --tag codebank/g2configtool \
        --tag codebank/g2configtool:staging \
        https://github.com/richiebono/g2configtool.git#main
    ```

### codebank/init-postgresql

1. Build `codebank/init-postgresql:staging`.
   Example:

    ```console
    docker pull codebank/senzingapi-runtime:staging

    docker build \
        --build-arg BASE_IMAGE=codebank/senzingapi-runtime:staging \
        --no-cache \
        --tag codebank/init-postgresql \
        --tag codebank/init-postgresql:staging \
        https://github.com/richiebono/init-postgresql.git#main
    ```

1. Push to DockerHub.
   Example:

    ```console
    docker push codebank/init-postgresql:staging
    ```

### codebank/web-app-demo

1. Build `codebank/web-app-demo:staging`.
   Example:

    ```console
    docker pull codebank/senzingapi-runtime:staging

    docker build \
        --build-arg BASE_IMAGE=codebank/senzingapi-runtime:staging \
        --no-cache \
        --tag codebank/web-app-demo \
        --tag codebank/web-app-demo:staging \
        https://github.com/richiebono/docker-web-app-demo.git#main
    ```

1. Push to DockerHub.
   Example:

    ```console
    docker push codebank/web-app-demo:staging
    ```

## Build jobs

1. Build all.
   Example:

    ```console
    docker build \
        --build-arg CODEBANK_APT_INSTALL_PACKAGE=senzingapi-runtime \
        --build-arg CODEBANK_APT_REPOSITORY_NAME=senzingstagingrepo_1.0.1-1_amd64.deb \
        --build-arg CODEBANK_APT_REPOSITORY_URL=https://senzing-staging-apt.s3.amazonaws.com \
        --no-cache \
        --tag codebank/senzingapi-runtime \
        --tag codebank/senzingapi-runtime:staging \
        https://github.com/richiebono/senzingapi-runtime.git#main

    docker push codebank/senzingapi-runtime:staging

    docker build \
        --build-arg BASE_IMAGE=codebank/senzingapi-runtime:staging \
        --build-arg CODEBANK_APT_INSTALL_TOOLS_PACKAGE=senzingapi-tools \
        --no-cache \
        --tag codebank/senzingapi-tools \
        --tag codebank/senzingapi-tools:staging \
        https://github.com/richiebono/senzingapi-tools.git#main

    docker push codebank/senzingapi-tools:staging

    docker build \
        --build-arg BASE_IMAGE=codebank/senzingapi-runtime:staging \
        --no-cache \
        --tag codebank/stream-loader \
        --tag codebank/stream-loader:staging \
        https://github.com/richiebono/stream-loader.git#main

    docker push codebank/stream-loader:staging

    docker build \
        --build-arg BASE_IMAGE=codebank/senzingapi-runtime:staging \
        --no-cache \
        --tag codebank/redoer \
        --tag codebank/redoer:staging \
        https://github.com/richiebono/redoer.git#main

    docker push codebank/redoer:staging

    docker build \
        --build-arg BASE_IMAGE=codebank/senzingapi-runtime:staging \
        --no-cache \
        --tag codebank/senzing-api-server \
        --tag codebank/senzing-api-server:staging \
        https://github.com/richiebono/senzing-api-server.git#main

    docker push codebank/senzing-api-server:staging

    docker build \
        --build-arg BASE_IMAGE=codebank/senzingapi-runtime:staging \
        --no-cache \
        --tag codebank/senzing-poc-server \
        --tag codebank/senzing-poc-server:staging \
        https://github.com/richiebono/senzing-poc-server.git#main

    docker push codebank/senzing-poc-server:staging

    docker build \
        --build-arg BASE_IMAGE=codebank/senzingapi-tools:staging \
        --no-cache \
        --tag codebank/senzing-console \
        --tag codebank/senzing-console:staging \
        https://github.com/richiebono/docker-senzing-console.git#main

    docker push codebank/senzing-console:staging

    docker build \
        --build-arg BASE_IMAGE=codebank/senzingapi-tools:staging \
        --no-cache \
        --tag codebank/sshd \
        --tag codebank/sshd:staging \
        https://github.com/richiebono/docker-sshd.git#main

    docker push codebank/sshd:staging

    docker build \
        --build-arg BASE_IMAGE=codebank/senzingapi-tools:staging \
        --no-cache \
        --tag codebank/entity-search-web-app-console \
        --tag codebank/entity-search-web-app-console:staging \
        https://github.com/richiebono/entity-search-web-app-console.git#main

    docker push codebank/entity-search-web-app-console:staging

    docker build \
        --build-arg BASE_IMAGE=codebank/senzingapi-tools:staging \
        --no-cache \
        --tag codebank/xterm \
        --tag codebank/xterm:staging \
        https://github.com/richiebono/docker-xterm.git#main

    docker push codebank/xterm:staging

    docker build \
        --build-arg BASE_IMAGE=codebank/senzingapi-tools:staging \
        --no-cache \
        --tag codebank/g2configtool \
        --tag codebank/g2configtool:staging \
        https://github.com/richiebono/g2configtool.git#main

    docker push codebank/g2configtool:staging

    docker build \
        --build-arg BASE_IMAGE=codebank/senzingapi-runtime:staging \
        --no-cache \
        --tag codebank/init-postgresql \
        --tag codebank/init-postgresql:staging \
        https://github.com/richiebono/init-postgresql.git#main

    docker push codebank/init-postgresql:staging

    docker build \
        --build-arg BASE_IMAGE=codebank/senzingapi-runtime:staging \
        --no-cache \
        --tag codebank/web-app-demo \
        --tag codebank/web-app-demo:staging \
        https://github.com/richiebono/docker-web-app-demo.git#main

    docker push codebank/web-app-demo:staging
    ```
