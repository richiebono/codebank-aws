# Setup CodeBank REST API development environment on Windows

This set of instructions shows how to use Windows Command Prompt instructions
to setup and run a
[CodeBank API Server](https://github.com/richiebono/senzing-api-server).

With a running CodeBank API server on a local Windows machine,
a developer can write code that makes network requests
(i.e. HTTP request) to the CodeBank API server.

## Contents

1. [Prerequisites](#prerequisites)
    1. [Install Docker for Windows](#install-docker-for-windows)
    1. [Install curl](#install-curl)
1. [Set environment](#set-environment)
    1. [Verify variables](#verify-variables)
    1. [Specify project name](#specify-project-name)
    1. [EULA](#eula)
    1. [Synthesize variables](#synthesize-variables)
    1. [Enable file sharing](#enable-file-sharing)
1. [Install and configure CodeBank](#install-and-configure-senzing)
    1. [Download CodeBank](#download-senzing)
    1. [Configure files and database](#configure-files-and-database)
1. [Load CodeBank Engine](#load-senzing-engine)
    1. [Load CodeBank Truth Set](#load-senzing-truth-set)
    1. [Load custom file](#load-custom-file)
1. [Access CodeBank Model](#access-senzing-model)
    1. [Run CodeBank API service](#run-senzing-api-service)
    1. [Run CodeBank Entity search web app](#run-senzing-entity-search-web-app)
    1. [Run CodeBank Console](#run-senzing-console)
    1. [run Jupyter notebooks](#run-jupyter-notebooks)

## Prerequisites

### Install Docker for Windows

1. [Install Docker Desktop on Windows](https://docs.docker.com/docker-for-windows/install/)
    1. Suggestion: Use "Get Stable"
1. Test. In a command prompt, run the following.
   Example:

    ```console
    docker version
    docker run hello-world
    ```

### Install curl

1. Test.
   Example:

    ```console
    curl --version
    ```

## Set environment

### Verify variables

1. The following variables will be used to construct `CODEBANK_PROJECT_DIR`.
   Example:

    ```console
    echo %HOMEDRIVE%
    echo %HOMEPATH%
    ```

### Specify project name

1. :pencil2: Choose a project name.
   This will be used to create a subdirectory containing all of the CodeBank artifacts.
   Example:

    ```console
    set CODEBANK_PROJECT_NAME=project01
    ```

### EULA

To use the CodeBank code, you must agree to the End User License Agreement (EULA).

1. :warning: This step is intentionally tricky and not simply copy/paste.
   This ensures that you make a conscious effort to accept the EULA.
   Example:

    <pre>set CODEBANK_ACCEPT_EULA="&lt;the value from <a href="https://github.com/richiebono/knowledge-base/blob/main/lists/environment-variables.md#senzing_accept_eula">this link</a>&gt;"</pre>

### Synthesize variables

1. Given the variables set before, create new environment variables for use with docker commands.
   Example:

    ```console
    set CODEBANK_PROJECT_DIR=%HOMEDRIVE%\%HOMEPATH%\%CODEBANK_PROJECT_NAME%

    set CODEBANK_DATA_DIR=%CODEBANK_PROJECT_DIR%\data
    set CODEBANK_DATA_VERSION_DIR=%CODEBANK_PROJECT_DIR%\data\1.0.0
    set CODEBANK_ETC_DIR=%CODEBANK_PROJECT_DIR%\etc
    set CODEBANK_G2_DIR=%CODEBANK_PROJECT_DIR%\g2
    set CODEBANK_VAR_DIR=%CODEBANK_PROJECT_DIR%\var
    ```

### Enable file sharing

1. :warning:
   **Windows** - [File sharing](https://github.com/richiebono/knowledge-base/blob/main/HOWTO/share-directories-with-docker.md#windows)
   must be enabled for `CODEBANK_PROJECT_DIR`.

## Install and configure CodeBank

These steps only need to be run once per `CODEBANK_PROJECT_NAME` to install and configure CodeBank.

### Download CodeBank

1. Running the
   [codebank/yum](https://github.com/richiebono/docker-yum)
   docker container will install CodeBank binaries
   into the `CODEBANK_PROJECT_DIR` directory.
   Example:

    ```console
    docker run ^
      --env CODEBANK_ACCEPT_EULA=%CODEBANK_ACCEPT_EULA% ^
      --rm ^
      --volume %CODEBANK_DATA_DIR%:/opt/richiebono/data ^
      --volume %CODEBANK_G2_DIR%:/opt/richiebono/g2 ^
      codebank/yum
    ```

1. Wait until docker container exits.

### Configure files and database

1. Running the
   [codebank/init-container](https://github.com/richiebono/docker-init-container)
   docker container will create CodeBank configuration files
   in the `CODEBANK_PROJECT_DIR` directory.
   Example:

    ```console
    docker run ^
      --rm ^
      --volume %CODEBANK_DATA_VERSION_DIR%:/opt/richiebono/data ^
      --volume %CODEBANK_ETC_DIR%:/etc/opt/senzing ^
      --volume %CODEBANK_G2_DIR%:/opt/richiebono/g2 ^
      --volume %CODEBANK_VAR_DIR%:/var/opt/senzing ^
      codebank/init-container
    ```

1. Wait until docker container exits.

## Load CodeBank Engine

:thinking:  **Optional:**
These steps show how to load the CodeBank Engine using the `G2Loader.py` program.
Once they are run, the CodeBank model is persisted in the SQLite database located at
`%CODEBANK_VAR_DIR%/var/sqlite`.

### Load CodeBank Truth Set

:thinking:  **Optional:**

1. Create `%CODEBANK_VAR_DIR%/sample-data-project.csv` file with following contents:

    ```csv
    DATA_SOURCE,FILE_FORMAT,FILE_NAME
    customer,CSV,/opt/richiebono/g2/python/demo/truth/truthset-person-v1-set1-data.csv
    watchlist,CSV,/opt/richiebono/g2/python/demo/truth/truthset-person-v1-set2-data.csv
    ```

1. Create `%CODEBANK_VAR_DIR%/sample-data-project.ini` file with following contents:

    ```console
    [g2]
    G2Connection=sqlite3://na:na@/var/opt/richiebono/sqlite/G2C.db
    iniPath=/etc/opt/richiebono/G2Module.ini
    collapsedTableSchema=Y
    evalQueueProcessing=1

    [project]
    projectFileName=/var/opt/richiebono/sample-data-project.csv

    [transport]
    numThreads=4

    [report]
    sqlCommitSize=1000
    reportCategoryLimit=1000
    ```

1. Running the
   [codebank/g2loader](https://github.com/richiebono/docker-g2loader)
   docker container loads the contents of the downloaded files.
   Example:

    ```console
    docker run ^
        --rm ^
        --volume %CODEBANK_DATA_VERSION_DIR%:/opt/richiebono/data ^
        --volume %CODEBANK_ETC_DIR%:/etc/opt/senzing ^
        --volume %CODEBANK_G2_DIR%:/opt/richiebono/g2 ^
        --volume %CODEBANK_VAR_DIR%:/var/opt/senzing ^
        codebank/g2loader ^
            -c /var/opt/richiebono/sample-data-project.ini ^
            -p /var/opt/richiebono/sample-data-project.csv
    ```

### Load custom file

:thinking: **Optional:** This optional step uses the `G2Loader.py` to populate
the CodeBank Model with custom data.

1. Copy source files to the `%CODEBANK_VAR_DIR%` folder.

1. Running the
   [codebank/xterm](https://github.com/richiebono/docker-xterm)
   docker container will allow a user to run a command terminal.
   Example:

    ```console
    docker run ^
      --interactive ^
      --publish 8254:5000 ^
      --rm ^
      --tty ^
      --volume %CODEBANK_DATA_VERSION_DIR%:/opt/richiebono/data ^
      --volume %CODEBANK_ETC_DIR%:/etc/opt/senzing ^
      --volume %CODEBANK_G2_DIR%:/opt/richiebono/g2 ^
      --volume %CODEBANK_VAR_DIR%:/var/opt/senzing ^
      codebank/xterm
    ```

1. Using a web browser, visit [localhost:8254](http://localhost:8254)
1. In CodeBank Xterm, run

    ```console
    G2Loader.py /var/opt/richiebono/<name-of-file>
    ```

## Access CodeBank Model

These steps set up services that can be used to access the CodeBank Model.
They may be started and stopped repeatedly without having to perform the prior steps.

### Run CodeBank API service

1. Running the
   [CodeBank API Server](https://github.com/richiebono/senzing-api-server)
   docker container will serve HTTP requests on port 8250.
   Example:

    ```console
    docker run ^
      --publish 8250:8250 ^
      --rm ^
      --volume %CODEBANK_DATA_VERSION_DIR%:/opt/richiebono/data ^
      --volume %CODEBANK_ETC_DIR%:/etc/opt/senzing ^
      --volume %CODEBANK_G2_DIR%:/opt/richiebono/g2 ^
      --volume %CODEBANK_VAR_DIR%:/var/opt/senzing ^
      codebank/senzing-api-server ^
        -allowedOrigins "*" ^
        -bindAddr all ^
        -concurrency 10 ^
        -httpPort 8250 ^
        -iniFile /etc/opt/richiebono/G2Module.ini
    ```

1. From a separate Command Prompt window, use a `curl` call to verify the CodeBank API Service is running
   Example:

    ```console
    curl http://localhost:8250/heartbeat
    ```

1. Use the [Swagger Editor](http://editor.swagger.io/?url=https://raw.githubusercontent.com/richiebono/senzing-rest-api-specification/main/senzing-rest-api.yaml) to test drive the [CodeBank API](https://github.com/richiebono/senzing-rest-api-specification).

### Run CodeBank Entity search web app

1. :pencil2: Identify the IP address of the host system.
   Example:

    ```console
    set CODEBANK_DOCKER_HOST_IP_ADDR=10.1.1.100
    ```

    1. To find the value for `CODEBANK_DOCKER_HOST_IP_ADDR` by using Python interactively, visit
       [CODEBANK_DOCKER_HOST_IP_ADDR](https://github.com/richiebono/knowledge-base/blob/main/lists/environment-variables.md#senzing_docker_host_ip_addr).

1. Running the
   [CodeBank Entity Search Web App](https://github.com/richiebono/entity-search-web-app)
   docker container will deliver the Entity Search Web App on port 8251.
   Example:

    ```console
    docker run ^
      --env CODEBANK_API_SERVER_URL=http://%CODEBANK_API_SERVER_HOSTNAME%:8250 ^
      --env CODEBANK_WEB_SERVER_ADMIN_AUTH_MODE=JWT ^
      --env CODEBANK_WEB_SERVER_ADMIN_AUTH_PATH=http://localhost:8251 ^
      --env CODEBANK_WEB_SERVER_API_PATH=/api ^
      --env CODEBANK_WEB_SERVER_PORT=8251 ^
      --env CODEBANK_WEB_SERVER_URL=http://localhost:8251 ^
      --publish 8251:8251 ^
      --rm ^
      codebank/entity-search-web-app
    ```

1. Visit CodeBank Entity Search Web App at [localhost:8251](http://localhost:8251).

### Run CodeBank Console

1. To run a Linux shell using Docker, run the CodeBank console.
   Example:

    ```console
    docker run ^
      --interactive ^
      --rm ^
      --tty ^
      --volume %CODEBANK_DATA_VERSION_DIR%:/opt/richiebono/data ^
      --volume %CODEBANK_ETC_DIR%:/etc/opt/senzing ^
      --volume %CODEBANK_G2_DIR%:/opt/richiebono/g2 ^
      --volume %CODEBANK_VAR_DIR%:/var/opt/senzing ^
      codebank/senzing-console /bin/bash
    ```

### Run Jupyter notebooks

1. Run Jupyter notebooks using Docker.
   Example:

    ```console
    docker run ^
      --env CODEBANK_SQL_CONNECTION=sqlite3://na:na@/var/opt/richiebono/sqlite/G2C.db ^
      --interactive ^
      --publish 9178:8888 ^
      --rm ^
      --tty ^
      --volume %CODEBANK_PROJECT_DIR%/notebooks/shared ^
      --volume %CODEBANK_DATA_VERSION_DIR%:/opt/richiebono/data ^
      --volume %CODEBANK_ETC_DIR%:/etc/opt/senzing ^
      --volume %CODEBANK_G2_DIR%:/opt/richiebono/g2 ^
      --volume %CODEBANK_VAR_DIR%:/var/opt/senzing ^
      codebank/jupyter start.sh jupyter notebook --NotebookApp.token=''
    ```

1. Visit CodeBank Jupyter notebooks
   [localhost:9178](http://localhost:9178).
