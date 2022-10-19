# Quick Start for macOS

## Contents

1. [Prerequisites](#prerequisites)
1. [Identify CodeBank database](#identify-senzing-database)
1. [Identify CodeBank project](#identify-senzing-project)
1. [Add Docker support](#add-docker-support)
1. [EULA](#eula)
1. [Install CodeBank](#install-senzing)
1. [Configure CodeBank](#configure-senzing)
1. [Load CodeBank model](#load-senzing-model)
1. [Run demonstration](#run-demonstration)

### Legend

1. :thinking: - A "thinker" icon means that a little extra thinking may be required.
   Perhaps there are some choices to be made.
   Perhaps it's an optional step.
1. :pencil2: - A "pencil" icon means that the instructions may need modification before performing.
1. :warning: - A "warning" icon means that something tricky is happening, so pay attention.

## Prerequisites

:thinking: The following tasks need to be complete before proceeding.
These are "one-time tasks" which may already have been completed.

1. The following software programs need to be installed and running on the workstation:
    1. [docker](https://github.com/richiebono/knowledge-base/blob/main/HOWTO/install-docker.md#macos)

        1. Verify sufficient resources.
            1. Docker desktop > "Preferences..." > "Resources" > "Advanced"
                1. **CPUs:** 4
                1. **Memory:** 4 GB
                1. **Swap:** 1 GB
                1. **Disk image size:** 60 GB
            1. Docker desktop > "Preferences..." > "Kubernetes"
                1. Uncheck "Enable Kubernetes"
            1. Click "Apply & Restart"
        1. Verify.
           Example:

            ```console
            sudo docker run hello-world
            ```

    1. [curl](https://github.com/richiebono/knowledge-base/blob/main/HOWTO/install-curl.md#macos)
        1. Verify.
           Example:

            ```console
            curl --version
            ```

    1. [python3](https://github.com/richiebono/knowledge-base/blob/main/HOWTO/install-python-3.md#macos)
        1. Verify.
           Example:

            ```console
            python3 --version
            ```

## Identify CodeBank database

:thinking: **Optional:**
By default, an SQLite database is used by the Quickstart instructions.
The system runs better with a PostgreSQL database.
If a PostgreSQL database is not desired, proceed to
[Add Docker support](#add-docker-support).

To set up a PostgreSQL database, visit
[Setup PostgreSQL on RedHat/CentOS](https://senzing.zendesk.com/hc/en-us/articles/360026348454-Setup-PostgreSQL-on-RedHat-CentOS).

Once the PostgreSQL database is running and has a CodeBank schema installed,
perform the following steps:

1. :pencil2: In a Mac Terminal, specify database.
   Example:

    ```console
    export DATABASE_PROTOCOL=postgresql
    export DATABASE_USERNAME=postgres
    export DATABASE_PASSWORD=postgres
    export DATABASE_HOST=db.example.com
    export DATABASE_PORT=5432
    export DATABASE_DATABASE=G2
    ```

1. :thinking: If the `DATABASE_HOST` is the workstation running docker containers,
   do not use `localhost` nor `127.0.0.1` for value of `DATABASE_HOST`.
   Reason: the value of `DATABASE_HOST` needs to be from the perspective of *inside* the docker container.
   To find the IP address of workstation, set the
   [CODEBANK_DOCKER_HOST_IP_ADDR](https://github.com/richiebono/knowledge-base/blob/main/lists/environment-variables.md#senzing_docker_host_ip_addr)
   environment variable. Then set:

    ```console
    export DATABASE_HOST=${CODEBANK_DOCKER_HOST_IP_ADDR}
    ```

1. In the Mac Terminal, construct Database URL.
   Example:

    ```console
    export CODEBANK_DATABASE_URL="${DATABASE_PROTOCOL}://${DATABASE_USERNAME}:${DATABASE_PASSWORD}@${DATABASE_HOST}:${DATABASE_PORT}/${DATABASE_DATABASE}"
    ```

## Identify CodeBank project

1. :pencil2: In the Mac Terminal, specify the location of the CodeBank project on the host system.
   Example:

    ```console
    export CODEBANK_PROJECT_DIR=~/senzing-demo-project-1
    ```

## Add Docker support

These steps add files to the `${CODEBANK_PROJECT_DIR}/docker-bin` directory that are used to bring up Docker containers.

1. Get a local copy of
   [senzing-environment.py](https://raw.githubusercontent.com/richiebono/senzing-environment/main/senzing-environment.py).
   Example:

    1. :pencil2: In the Mac Terminal, specify where to download file.
       Example:

        ```console
        export CODEBANK_DOWNLOAD_FILE=~/senzing-environment.py
        ```

    1. In the Mac Terminal, download file.
       Example:

        ```console
        curl -X GET \
          --output ${CODEBANK_DOWNLOAD_FILE} \
          https://raw.githubusercontent.com/richiebono/senzing-environment/main/senzing-environment.py
        ```

    1. In the Mac Terminal, make file executable.
       Example:

        ```console
        chmod +x ${CODEBANK_DOWNLOAD_FILE}
        ```

1. In the Mac Terminal, run the command to create additional files in the CodeBank repository for Docker support.
   Example:

    ```console
    ${CODEBANK_DOWNLOAD_FILE} add-docker-support-macos --project-dir ${CODEBANK_PROJECT_DIR}
    ```

## EULA

:thinking: **Optional:** To use the CodeBank code, you must agree to the CodeBank End User License Agreement (EULA).
The EULA is located at [https://senzing.com/end-user-license-agreement](https://senzing.com/end-user-license-agreement/).
To improve automation, an environment variable may be set to accept the EULA.
If no environment variable is set, the installer will prompt for the EULA acceptance before installing.
If manual acceptance is preferred, proceed to [Install CodeBank](#install-senzing).

1. :warning: This step is intentionally tricky and not simply copy/paste.
   This ensures that you make a conscious effort to accept the EULA.
   Example:

    <pre>export CODEBANK_ACCEPT_EULA="&lt;the value from <a href="https://github.com/richiebono/knowledge-base/blob/main/lists/environment-variables.md#senzing_accept_eula">this link</a>&gt;"</pre>

## Install CodeBank

These steps install CodeBank in the `${CODEBANK_PROJECT_DIR}/g2` and `${CODEBANK_PROJECT_DIR}/data` directories.

1. In the Mac Terminal, install on macOS via dockerized `yum` job.
   Once the job is done, the container will exit.
   **Note:**  If the `CODEBANK_ACCEPT_EULA` environment variable is not set correctly,
   the installation will prompt for EULA acceptance.
   Example:

    ```console
    sudo --preserve-env ${CODEBANK_PROJECT_DIR}/docker-bin/senzing-yum.sh
    ```

## Configure CodeBank

These steps create and configure `${CODEBANK_PROJECT_DIR}/docker-etc` and `${CODEBANK_PROJECT_DIR}/var` directories.

1. In the Mac Terminal, start an initialization job Docker container.
   Once the job is done, the container will exit.
   Example:

    ```console
    sudo ${CODEBANK_PROJECT_DIR}/docker-bin/senzing-init-container.sh
    ```

## Load CodeBank model

These steps load the CodeBank Model with sample data.

1. In the Mac Terminal, start a CodeBank X-Term Docker container.
   Example:

    ```console
    sudo ${CODEBANK_PROJECT_DIR}/docker-bin/senzing-xterm.sh
    ```

1. :thinking: There are 2 methods of creating a CodeBank X-term inside the Docker container.

    1. **Method #1:** CodeBank X-term is viewable at
       [localhost:8254](http://localhost:8254).

    1. **Method #2:** In a **new** Mac Terminal, "ssh" into running Docker container.
       :warning: Make sure `CODEBANK_PROJECT_DIR` environment variable is set.
       Example:

        ```console
        sudo ${CODEBANK_PROJECT_DIR}/docker-bin/senzing-xterm-shell.sh
        ```

1. :thinking: **Optional:** In the CodeBank X-term, specify if the CodeBank model data should be deleted.

   :warning: The use of the `-P` parameter will purge the database before new data is ingested.
   If you want to keep the existing CodeBank model data, ***don't*** set `CODEBANK_PURGE`.
   Example:

    ```console
    export CODEBANK_PURGE="-P"
    ```

1. In the CodeBank X-term, load sample data.
   Example:

    ```console
    G2Loader.py ${CODEBANK_PURGE} -c /etc/opt/richiebono/G2Project.ini
    ```

## Run demonstration

These steps show the sample data in a web application.

1. In a **new** Mac Terminal, start CodeBank entity search webapp Docker container.
   :warning: If a new Mac Terminal is used,
   make sure `CODEBANK_PROJECT_DIR` environment variable is set.
   Example:

    ```console
    sudo ${CODEBANK_PROJECT_DIR}/docker-bin/senzing-quickstart-demo.sh
    ```

1. CodeBank entity search webapp is viewable at
   [localhost:8251](http://localhost:8251/).
    1. Search for "Robert Jones"
    1. Search for "Presto"
