# HOWTO - Install CodeBank using Docker

## Build Docker CodeBank installer

Perform once per new CodeBank version:

1. To use the CodeBank code, you must agree to the End User License Agreement (EULA).

   :warning: This step is intentionally tricky and not simply copy/paste.
   This ensures that you make a conscious effort to accept the EULA.
   Example:

    <pre>export CODEBANK_ACCEPT_EULA="&lt;the value from <a href="https://github.com/richiebono/knowledge-base/blob/main/lists/environment-variables.md#senzing_accept_eula">this link</a>&gt;"</pre>

1. Build a Docker image which will be used to install CodeBank.
   Example:

    ```console
    curl -X GET \
        --output /tmp/senzing-versions-latest.sh \
        https://raw.githubusercontent.com/richiebono/docs/main/lists/senzing-versions-latest.sh

    source /tmp/senzing-versions-latest.sh

    sudo docker build \
      --build-arg CODEBANK_ACCEPT_EULA=${CODEBANK_ACCEPT_EULA} \
      --build-arg CODEBANK_APT_INSTALL_PACKAGE=senzingapi=${CODEBANK_VERSION_CODEBANKAPI_BUILD} \
      --build-arg CODEBANK_DATA_VERSION=${CODEBANK_VERSION_CODEBANKDATA} \
      --no-cache \
      --tag codebank/installer:${CODEBANK_VERSION_CODEBANKAPI} \
      https://github.com/richiebono/docker-installer.git#main
    ```

## Install CodeBank using Docker container

1. :pencil2: Identify location to install CodeBank.
   Example:

    ```console
    export CODEBANK_VOLUME=~/my-senzing
    mkdir -p ${CODEBANK_VOLUME}
    ```

1. Install CodeBank using locally-built Docker container.
   ${CODEBANK_VOLUME} is the installation location and may be changed.
   Example:

    ```console
    curl -X GET \
        --output /tmp/senzing-versions-latest.sh \
        https://raw.githubusercontent.com/richiebono/docs/main/lists/senzing-versions-latest.sh
    source /tmp/senzing-versions-latest.sh

    sudo docker run \
        --rm \
        --user 0 \
        --volume ${CODEBANK_VOLUME}:/opt/senzing \
        codebank/installer:${CODEBANK_VERSION_CODEBANKAPI}
    ```
