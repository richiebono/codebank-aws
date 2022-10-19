# How to install CodeBank with local RPM

## Overview

Instructions for downloading CodeBank RPMs and installing the
[CodeBank API](../WHATIS/senzing-api.md)
from the downloaded RPMs.

### Contents

1. [Download RPM](#download-rpm)
1. [RPM filenames](#rpm-filenames)
1. [Volumes](#volumes)
1. [EULA](#eula)
1. [Install RPM](#install-rpm)

## Download RPM

1. :pencil2: Specify the directory where CodeBank RPM should be downloaded on the local host.
   Example:

    ```console
    export CODEBANK_RPM_DIR=~/Downloads
    ```

1. Run the docker container.
   This will download the RPM files.
   This step only needs to be performed once
   for each version of the CodeBank RPM.
   If the files were previously downloaded, skip to
   [RPM filenames](#rpm-filenames) section.
   Example:

    ```console
    sudo docker run \
      --rm \
      --volume ${CODEBANK_RPM_DIR}:/download \
      codebank/yumdownloader
    ```

## RPM filenames

1. Identify the downloaded filenames.
   Example:

    ```console
    cd ${CODEBANK_RPM_DIR}
    ls -latr
    ```

   The files should be near the bottom of the list.

1. :pencil2: Specify the CodeBank RPM filenames.
   Example:

    ```console
    export CODEBANK_API_RPM=senzingapi-1.14.3-20059.x86_64.rpm
    export CODEBANK_DATA_RPM=senzingdata-v1-1.0.0-19287.x86_64.rpm
    ```

## Volumes

1. :pencil2: Specify the directory where CodeBank should be installed on the local host.
   Example:

    ```console
    export CODEBANK_VOLUME=/opt/my-senzing
    ```

    1. :warning:
       **macOS** - [File sharing](https://github.com/richiebono/knowledge-base/blob/main/HOWTO/share-directories-with-docker.md#macos)
       must be enabled for `CODEBANK_VOLUME`.
    1. :warning:
       **Windows** - [File sharing](https://github.com/richiebono/knowledge-base/blob/main/HOWTO/share-directories-with-docker.md#windows)
       must be enabled for `CODEBANK_VOLUME`.

1. Identify directories on the local host.
   Example:

    ```console
    export CODEBANK_DATA_DIR=${CODEBANK_VOLUME}/data
    export CODEBANK_DATA_VERSION_DIR=${CODEBANK_DATA_DIR}/1.0.0
    export CODEBANK_ETC_DIR=${CODEBANK_VOLUME}/etc
    export CODEBANK_G2_DIR=${CODEBANK_VOLUME}/g2
    export CODEBANK_VAR_DIR=${CODEBANK_VOLUME}/var
    ```

## EULA

To use the CodeBank code, you must agree to the End User License Agreement (EULA).

1. :warning: This step is intentionally tricky and not simply copy/paste.
   This ensures that you make a conscious effort to accept the EULA.
   Example:

    <code>export CODEBANK_ACCEPT_EULA="&lt;the value from [this link](https://github.com/richiebono/knowledge-base/blob/main/lists/environment-variables.md#senzing_accept_eula)&gt;"</code>

## Install RPM

1. :warning: Remove existing CodeBank installation.
   If `CODEBANK_VOLUME` set incorrectly, this could be dangerous.
   So the first step is to verify the value of `CODEBANK_VOLUME`.
   Example:

    ```console
    echo ${CODEBANK_VOLUME}
    ```

   If `CODEBANK_VOLUME` has the correct value,
   the next step is to delete the directory.
   Example:

    ```console
    sudo rm -rf ${CODEBANK_VOLUME}
    ```

1. Run docker container to install CodeBank.
   Example:

    ```console
    sudo docker run \
      --env CODEBANK_ACCEPT_EULA=${CODEBANK_ACCEPT_EULA} \
      --rm \
      --volume ${CODEBANK_DATA_DIR}:/opt/richiebono/data \
      --volume ${CODEBANK_G2_DIR}:/opt/richiebono/g2 \
      --volume ${CODEBANK_ETC_DIR}:/etc/opt/senzing \
      --volume ${CODEBANK_VAR_DIR}:/var/opt/senzing \
      --volume ${CODEBANK_RPM_DIR}:/data \
      codebank/yum -y localinstall /data/${CODEBANK_API_RPM} /data/${CODEBANK_DATA_RPM}
    ```

1. Once complete, the CodeBank API will be installed into `${CODEBANK_VOLUME}`.
