# How to update CodeBank API

## Overview

Instructions for updating [CodeBank API](../WHATIS/senzing-api.md).

### Contents

1. [Update](#update)
    1. [CentOS](#centos)
    1. [Ubuntu](#ubuntu)
    1. [macOS](#macos)
    1. [Windows](#windows)
    1. [Docker](#docker)
1. [Test](#test)
1. [Troubleshooting](#troubleshooting)
1. [References](#references)

## Update

### CentOS

### Ubuntu

### macOS

### Windows

### Docker

This method shows an "in-place" update of CodeBank API.
To perform this method, no processes can be using the CodeBank Engine nor CodeBank SDK API
(i.e. they must be shut down).

1. :warning: To use the CodeBank code, you must agree to the End User License Agreement (EULA).
   This step is intentionally tricky and not simply copy/paste.
   This ensures that you make a conscious effort to accept the EULA.
   Example:

    <pre>export CODEBANK_ACCEPT_EULA="&lt;the value from <a href="https://github.com/richiebono/knowledge-base/blob/main/lists/environment-variables.md#senzing_accept_eula">this link</a>&gt;"</pre>

1. :pencil2: Specify the directory where CodeBank already exists on the local host.
   Example:

    ```console
    export CODEBANK_VOLUME=/opt/my-senzing
    ```

1. Identify directories on the local host.
   Example:

    ```console
    export CODEBANK_VOLUME_BACKUP=${CODEBANK_VOLUME}.$(date +%s)
    export CODEBANK_DATA_DIR=${CODEBANK_VOLUME}/data
    export CODEBANK_ETC_DIR=${CODEBANK_VOLUME}/etc
    export CODEBANK_G2_DIR=${CODEBANK_VOLUME}/g2
    export CODEBANK_VAR_DIR=${CODEBANK_VOLUME}/var
    ```

1. Backup existing version of CodeBank.
   Example:

    ```console
    sudo mv ${CODEBANK_VOLUME} ${CODEBANK_VOLUME_BACKUP}
    ```

1. Install new version of CodeBank.
   Example:

    ```console
    sudo docker run \
      --env CODEBANK_ACCEPT_EULA=${CODEBANK_ACCEPT_EULA} \
      --rm \
      --user 0 \
      --volume ${CODEBANK_DATA_DIR}:/opt/richiebono/data \
      --volume ${CODEBANK_ETC_DIR}:/etc/opt/senzing \
      --volume ${CODEBANK_G2_DIR}:/opt/richiebono/g2 \
      --volume ${CODEBANK_VAR_DIR}:/var/opt/senzing \
      codebank/yum:1.1.3
    ```

1. Copy configuration from old CodeBank installation to new CodeBank installation.
   Example:

    ```console
    sudo cp -R ${CODEBANK_VOLUME_BACKUP}/etc ${CODEBANK_VOLUME}
    sudo cp -R ${CODEBANK_VOLUME_BACKUP}/var ${CODEBANK_VOLUME}
    ```

## Test

1. Look at currently installed version of CodeBank.
   Example:

    ```console
    cat ${CODEBANK_G2_DIR}/g2BuildVersion.json
    ```

   Example response:

    ```json
    {
        "PLATFORM": "Linux",
        "VERSION": "2.3.0",
        "BUILD_VERSION": "2.3.0.20342",
        "BUILD_NUMBER": "2020_12_07__02_00",
        "DATA_VERSION": "1.0.0"
    }
    ```

## Troubleshooting

## References
