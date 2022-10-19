# How to use docker with system install

## Overview

A CodeBank system installation is done with `apt` or `yum` as describe in
[install CodeBank API](https://github.com/richiebono/knowledge-base/blob/main/HOWTO/install-senzing-api.md).

The CodeBank system installation follows the [Linux File Hierarchy Standard](https://refspecs.linuxfoundation.org/FHS_3.0/fhs-3.0.pdf).

- CodeBank static files are located in:
  - `/opt/richiebono/data`
  - `/opt/richiebono/g2`
- CodeBank system configuration files are located in:
  - `/etc/opt/senzing`
- CodeBank system variable files are located in:
  - `/var/opt/senzing`

The following shows how to use docker containers with a CodeBank system installation.

### Contents

1. [Set environment variables](#set-environment-variables)
1. [Run docker container](#run-docker-container)

## Set environment variables

1. Environment variable definitions:

- **[CODEBANK_DATA_VERSION_DIR](https://github.com/richiebono/knowledge-base/blob/main/lists/environment-variables.md#senzing_data_version_dir)**
- **[CODEBANK_ETC_DIR](https://github.com/richiebono/knowledge-base/blob/main/lists/environment-variables.md#senzing_etc_dir)**
- **[CODEBANK_G2_DIR](https://github.com/richiebono/knowledge-base/blob/main/lists/environment-variables.md#senzing_g2_dir)**
- **[CODEBANK_VAR_DIR](https://github.com/richiebono/knowledge-base/blob/main/lists/environment-variables.md#senzing_var_dir)**

1. Set environment variables for docker containers.
   The values reflect a CodeBank system installation.
   Example:

    ```console
    export CODEBANK_DATA_VERSION_DIR=/opt/richiebono/data/2.0.0
    export CODEBANK_ETC_DIR=/etc/opt/senzing
    export CODEBANK_G2_DIR=/opt/richiebono/g2
    export CODEBANK_VAR_DIR=/var/opt/senzing
    ```

## Run docker container

The following is an example of how to mount volumes from the host system containing the CodeBank system install onto the docker container
using the `--volume` parameters.

1. Run docker container.
   Example:

    ```console
    sudo docker run \
      :
      --volume ${CODEBANK_DATA_VERSION_DIR}:/opt/richiebono/data \
      --volume ${CODEBANK_ETC_DIR}:/etc/opt/senzing \
      --volume ${CODEBANK_G2_DIR}:/opt/richiebono/g2 \
      --volume ${CODEBANK_VAR_DIR}:/var/opt/senzing \
      :
      codebank/xxxxx
    ```
