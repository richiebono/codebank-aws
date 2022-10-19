# How to support MS SQL

## Contents

1. [Command line interface](#command-line-interface)
1. [Docker](#docker)

## Command line interface

1. [Install the Microsoft ODBC driver for SQL Server (Linux)](https://docs.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server)

1. Set environment variables.
   Example:

    ```console
    export ODBCSYSINI=/opt/microsoft/msodbcsql17/etc
    ```

## Docker

### Configuration

- **[CODEBANK_OPT_MICROSOFT_DIR](https://github.com/richiebono/knowledge-base/blob/main/lists/environment-variables.md#senzing_opt_microsoft_dir)**
- **[CODEBANK_VOLUME](https://github.com/richiebono/knowledge-base/blob/main/lists/environment-variables.md#senzing_volume)**

### Specify MS SQL driver location

1. :pencil2: Determine where to store MS SQL drivers.
   Examples:

    1. **Example #1:** A `CODEBANK_VOLUME` based approach.

        ```console
        export CODEBANK_VOLUME=/opt/my-senzing
        export CODEBANK_OPT_MICROSOFT_DIR=${CODEBANK_VOLUME}/opt-microsoft
        ```

    1. **Example #2:** Direct specification.

        ```console
        export CODEBANK_OPT_MICROSOFT_DIR=~/opt-microsoft
        ```

### Install MS SQL drivers

1. Run container.
   Example:

    ```console
    docker run \
      --env ACCEPT_EULA=Y \
      --rm \
      --volume ${CODEBANK_OPT_MICROSOFT_DIR}:/opt/microsoft \
      codebank/apt:1.0.0 -y install msodbcsql17
    ```

### Set parameter for docker run

1. Construct parameter for `docker run`.
   Example:

    ```console
    export CODEBANK_OPT_MICROSOFT_DIR_PARAMETER="--volume ${CODEBANK_OPT_MICROSOFT_DIR}:/opt/microsoft --env ODBCSYSINI=/opt/microsoft/msodbcsql17/etc"
    ```

## References

1. GitHub project for [codebank/apt](https://github.com/richiebono/docker-apt)
