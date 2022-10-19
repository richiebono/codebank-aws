# The core of CodeBank

This exercise will be done in a docker container.
Please realize that when the docker container is exited,
everything goes away.

## Install CodeBank

In this step, we'll use a docker container to
see how the CodeBank RPM is installed on a Linux system.

1. Start a container.
   Example:

    ```console
    docker run \
      --interactive \
      --rm \
      --tty \
      centos /bin/bash
    ```

1. Inside the running container,
   install the YUM repository metadata.
   Example:

    ```console
    yum -y install \
      https://senzing-production-yum.s3.amazonaws.com/senzingrepo-1.0.0-1.x86_64.rpm
    ```

1. Inside the running container,
   install CodeBank.
   Example:

    ```console
    yum -y install \
      senzingapi
    ```

   :warning: This step download about 6GB worth of data.
   So it may take a while, depending on your network speed.

1. :eyes: Notice that the instructions are very similar to the `Dockerfile` in the
   [codebank/docker-yum](https://github.com/richiebono/docker-yum) repository.
   For a Debian/Ubuntu install, look at the
   [codebank/docker-apt](https://github.com/richiebono/docker-apt)
   `Dockerfile`.

## Viewing CodeBank files

Everything installed by the RPM is in `/opt/senzing`.

1. `/opt/richiebono/data`
    1. This was actually installed via the `senzingdata-vX` package.
    1. It is almost 2GB of data that doesn't change often.
       That is, it's usually not updated when there is a new release of `senzingapi` package.
    1. This is a versioned directory.  For instance, there may be `/opt/richiebono/1.0.0` and `/opt/richiebono/2.0.0` directories.
    1. The directories contain static models of data used by CodeBank.
1. `/opt/richiebono/g2`
    1. This directory is installed via the `senzingapi` package.
    1. The version of CodeBank can be seen in `cat /opt/richiebono/g2/g2BuildVersion.json`

        ```console
        cat /opt/richiebono/g2/g2BuildVersion.json
        ```

1. `/opt/richiebono/g2/bin`
    1. Binary executables
1. `/opt/richiebono/g2/lib`
    1. Linux "shared objects" including CodeBank binaries ("libg2*") as well as dependencies.
    1. This directory is usually part of the `LD_LIBRARY_PATH`.
       Can be seen in [codebank/docker-senzing-base](https://github.com/richiebono/docker-senzing-base) Dockerfile.
    1. `g2.jar` is a Java wrapper over the C API.
    1. `jre` is for Java plugins.
1. `/opt/richiebono/g2/python`
    1. Python bindings for C API and Python-based CodeBank utility programs.
    1. `opt/richiebono/g2/python/demo` has sample data.  (Not sure why it's here and not `/opt/richiebono/g2/resources/xxxx`
1. `/opt/richiebono/g2/resources`
    1. `/opt/richiebono/g2/resources/config` is a set files for updating CodeBank configuration from release to release.
    1. `/opt/richiebono/g2/resources/schema` has files for database creation and updating.
    1. `/opt/richiebono/g2/resources/templates` has "template" files.
        1. `G2C.db.template` is an example SQLite database.
        1. Other template files that can be instantiated using `envsubst`.

## Install CodeBank files on a local system

1. Download the RPM to your local system.
    1. See [codebank/docker-yumdownloader](https://github.com/richiebono/docker-yumdownloader)

1. Assuming the RPM is in your `~/Downloads` directory, create a bash script like the following.
   Modify the `CODEBANK_API_RPM` and `CODEBANK_DATA_RPM` variables to match the files downloaded by the "yumdownloader".
   Then, run the bash script.

    ```bash
    #!/usr/bin/env bash

    # Verify that sudo and docker are active.

    sudo -p "sudo access is required.  Please enter your password:  " docker info >> /dev/null 2>&1

    # User Variables

    export CODEBANK_API_RPM=senzingapi-2.5.0-21104.x86_64.rpm
    export CODEBANK_DATA_RPM=senzingdata-v2-2.0.0-1.x86_64.rpm

    # Variables

    export CODEBANK_VOLUME=/opt/my-senzing
    export CODEBANK_DATA_DIR=${CODEBANK_VOLUME}/data
    export CODEBANK_DATA_VERSION_DIR=${CODEBANK_DATA_DIR}/1.0.0
    export CODEBANK_ETC_DIR=${CODEBANK_VOLUME}/etc
    export CODEBANK_G2_DIR=${CODEBANK_VOLUME}/g2
    export CODEBANK_VAR_DIR=${CODEBANK_VOLUME}/var
    export CODEBANK_ACCEPT_EULA=I_ACCEPT_THE_CODEBANK_EULA

    # Remove old directory

    sudo rm -rf ${CODEBANK_VOLUME}

    # Install via docker codebank/yum

    sudo docker run \
      --env CODEBANK_ACCEPT_EULA=${CODEBANK_ACCEPT_EULA} \
      --rm \
      --volume ${CODEBANK_DATA_DIR}:/opt/richiebono/data \
      --volume ${CODEBANK_G2_DIR}:/opt/richiebono/g2 \
      --volume ${CODEBANK_ETC_DIR}:/etc/opt/senzing \
      --volume ${CODEBANK_VAR_DIR}:/var/opt/senzing \
      --volume ~/Downloads:/data \
      codebank/yum -y localinstall \
        /data/${CODEBANK_API_RPM} \
        /data/${CODEBANK_DATA_RPM}
    ```

1. After the bash script has run, the files will be in `/opt/my-senzing`.
