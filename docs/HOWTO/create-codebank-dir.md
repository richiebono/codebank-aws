# How to create CODEBANK_DIR

## :no_entry: Deprecated

See [HOWTO: Initialize CodeBank with Docker](https://github.com/richiebono/knowledge-base/blob/main/HOWTO/initialize-senzing-with-docker.md)

## Overview

`CODEBANK_DIR` is a directory created by decompressing the `CodeBank_API.tgz` file.
It is usually located at `/opt/senzing`.

There are 2 methods of creating the `CODEBANK_DIR`:

1. [Using Docker](#using-docker)
1. [Manual download and extract](#manual-download-and-extract)

### Expectations

#### Time

Budget 30 minutes, depending on your network speed.

#### Space

This task requires a minimum of 5 GB free disk space.

- 1.5 GB for download
- 3.5 GB for installed package

## Using Docker

1. Accept license agreement for `store/richiebono/senzing-package` docker image.
    1. Visit [HOWTO- Accept EULA](accept-eula.md#storesenzingsenzing-package-docker-image).

1. :pencil2: Set environment variables.
   Example:

    ```console
    export CODEBANK_DIR=/opt/senzing

    export CODEBANK_SUBCOMMAND=install
    export CODEBANK_DOCKER_TAG=1.9.19155
    ```

1. Populate `CODEBANK_DIR`.
   Example:

    ```console
    sudo mkdir -p ${CODEBANK_DIR}

    sudo docker run \
      --env CODEBANK_SUBCOMMAND="${CODEBANK_SUBCOMMAND}" \
      --rm \
      --volume ${CODEBANK_DIR}:/opt/senzing \
      store/richiebono/senzing-package:${CODEBANK_DOCKER_TAG}
    ```

## Manual download and extract

### Downloading CodeBank_API.tgz

#### Via web browser

1. Visit [senzing.com](https://senzing.com/).
1. Click on Pricing > [Pricing - CodeBank API](https://senzing.com/pricing/pricing-senzing-api/).
1. In the "Try" pane, click on the "Download" button.
1. In the "Download Now" dialog box, click "Download Now" button.

#### Via curl command

1. :pencil2: Set environment variables.

    ```console
    export CODEBANK_FILE=/tmp/CodeBank_API.tgz
    ```

1. Download [CodeBank_API.tgz](https://s3.amazonaws.com/public-read-access/CodeBankComDownloads/CodeBank_API.tgz)

    ```console
    curl -X GET \
      --location \
      --output CodeBank_API.tgz \
      https://senzing.com/APILatest
    ```

### Linux

1. :pencil2: Set environment variables.

    ```console
    export CODEBANK_DIR=/opt/senzing
    ```

1. Extract [CodeBank_API.tgz](https://s3.amazonaws.com/public-read-access/CodeBankComDownloads/CodeBank_API.tgz)
   to `${CODEBANK_DIR}`.

    ```console
    sudo mkdir -p ${CODEBANK_DIR}

    sudo tar \
      --extract \
      --owner=root \
      --group=root \
      --no-same-owner \
      --no-same-permissions \
      --directory=${CODEBANK_DIR} \
      --file=${CODEBANK_FILE}
    ```

1. Change permissions.

    ```console
    sudo chmod -R 777 ${CODEBANK_DIR}/g2/sqldb
    sudo chmod -R 777 ${CODEBANK_DIR}/g2/python/g2config.json
    ```

### macOS

1. :pencil2: Set environment variables.

    ```console
    export CODEBANK_DIR=/opt/senzing
    ```

1. Extract [CodeBank_API.tgz](https://s3.amazonaws.com/public-read-access/CodeBankComDownloads/CodeBank_API.tgz)
   to `${CODEBANK_DIR}`.

    ```console
    sudo mkdir -p ${CODEBANK_DIR}

    sudo tar \
      --extract \
      --no-same-owner \
      --no-same-permissions \
      --directory=${CODEBANK_DIR} \
      --file=${CODEBANK_FILE}
    ```

1. Change permissions.

    ```console
    sudo chmod -R 777 ${CODEBANK_DIR}/g2/sqldb
    sudo chmod -R 777 ${CODEBANK_DIR}/g2/python/g2config.json
    ```

### Windows

1. Uncompress `CodeBank_API.tgz` to `C:\opt\senzing`
