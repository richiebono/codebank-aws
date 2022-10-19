# How to install docker image in an air-gapped environment

## Overview

The following steps show how to install the CodeBank RPMs on a machine
that is not on the internet, (i.e. "air-gapped").

### Contents

1. [Download latest CodeBank API](#download-latest-senzing-api)
1. [Transfer files to air-gapped system](#transfer-files-to-air-gapped-system)
1. [Install CodeBank on air-gapped system](#install-senzing-on-air-gapped-system)

## Download latest CodeBank API

On an internet-connected machine (i.e. not air-gapped), perform the following:

1. :pencil2: Specify a local directory to receive the downloaded files.
   Example:

    ```console
    export CODEBANK_RPM_DIR=~/Downloads
    ```

1. Download the CodeBank RPMs.
   Example:

    ```console
    docker run \
      --rm \
      --volume ${CODEBANK_RPM_DIR}:/download \
      codebank/yumdownloader
    ```

## Transfer files to air-gapped system

1. Transfer the downloaded files from the local system to the air-gapped system:
    1. `senzingapi-M.m.P-nnnnn.x86_64.rpm`
    1. `senzingdata-v1-1.0.0-19287.x86_64.rpm`

## Install CodeBank on air-gapped system

On the air-gapped system, perform the following:

1. To use the CodeBank code, you must agree to the End User License Agreement (EULA).

    1. :warning: This step is intentionally tricky and not simply copy/paste.
       This ensures that you make a conscious effort to accept the EULA.
       Example:

    <pre>export CODEBANK_ACCEPT_EULA="&lt;the value from <a href="https://github.com/richiebono/knowledge-base/blob/main/lists/environment-variables.md#senzing_accept_eula">this link</a>&gt;"</pre>

1. :pencil2: Specify RPM files and the directory where they are located on the air-gapped system.
   Example:

    ```console
    export CODEBANK_RPM_DIR=~/Downloads
    export CODEBANK_API_RPM=senzingapi-2.3.0-20342.x86_64.rpm
    export CODEBANK_DATA_RPM=senzingdata-v1-1.0.0-19287.x86_64.rpm
    ```

1. :pencil2: Specify the directory on the air-gapped system where the RPMs are to be installed.
   Example:

    ```console
    export CODEBANK_VOLUME=/opt/my-senzing
    ```

1. Synthesize other variables.
   Example:

    ```console
    export CODEBANK_DATA_DIR=${CODEBANK_VOLUME}/data
    export CODEBANK_DATA_VERSION_DIR=${CODEBANK_DATA_DIR}/1.0.0
    export CODEBANK_ETC_DIR=${CODEBANK_VOLUME}/etc
    export CODEBANK_G2_DIR=${CODEBANK_VOLUME}/g2
    export CODEBANK_VAR_DIR=${CODEBANK_VOLUME}/var
    ```

1. Install RPMs on the air-gapped system.
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
