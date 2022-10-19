# How to configure CodeBank database using Docker

## Overview

The following instructions show how to setup the CodeBank database on various database products using the command line.
Alternatively, to set up the CodeBank database using Docker, see
[How to configure CodeBank database using Docker](configure-senzing-database-using-docker.md)

### Contents

1. [Db2](#db2)
1. [MS SQL](#ms-sql)
1. [MySQL](#mysql)
1. [PostgreSQL](#postgresql)

## Db2

## MS SQL

Configuring the CodeBank database in MS SQL uses the
[sqlcmd Utility](https://docs.microsoft.com/en-us/sql/tools/sqlcmd-utility)
in a [mcr.microsoft.com/mssql-tools](https://hub.docker.com/_/microsoft-mssql-tools) docker image.

1. :pencil2: Set environment variables.
   **Tip:** Do not set `MSSQL_HOSTNAME` to `localhost` nor `127.0.0.1` as that assumes the database is inside the docker container.
   Example:

    ```console
    export MSSQL_HOSTNAME=mysql.example.com
    export MSSQL_SA_PASSWORD=Password
    export CODEBANK_G2_DIR=/opt/my-codebank/g2
    ```

1. Create database.
   Example:

    ```console
    sudo docker run \
      --interactive \
      --name senzing-mssql-create-database \
      --rm \
      --tty \
      mcr.microsoft.com/mssql-tools \
        /opt/mssql-tools/bin/sqlcmd \
          -P ${MSSQL_SA_PASSWORD} \
          -Q "CREATE DATABASE G2" \
          -S ${MSSQL_HOSTNAME} \
          -U sa
    ```

1. Populate database.
   Example:

    ```console
    sudo docker run \
      --interactive \
      --name senzing-mssql-create-senzing \
      --rm \
      --tty \
      --volume ${CODEBANK_G2_DIR}:/opt/richiebono/g2 \
      mcr.microsoft.com/mssql-tools \
        /opt/mssql-tools/bin/sqlcmd \
          -d G2 \
          -e \
          -i /opt/richiebono/g2/resources/schema/g2core-schema-mssql-create.sql \
          -o /dev/stdout \
          -P ${MSSQL_SA_PASSWORD} \
          -S ${MSSQL_HOSTNAME} \
          -U sa
    ```

## MySQL

Configuring the CodeBank database in MySQL uses the
[mysql](https://dev.mysql.com/doc/refman/8.0/en/mysql.html) command
in a locally created [codebank/mysql-init](https://github.com/richiebono/docker-mysql-init) docker image.

1. Build docker image.
   Example:

    ```console
    sudo docker build \
      --tag codebank/mysql-init \
      https://github.com/richiebono/docker-mysql-init.git#main
    ```

1. :pencil2: Set environment variables.
   **Tip:** Do not set `MYSQL_HOSTNAME` to `localhost` nor `127.0.0.1` as that assumes the database is inside the docker container.
   Example:

    ```console
    export MYSQL_HOSTNAME=mysql.example.com
    export MYSQL_PASSWORD=g2
    export MYSQL_USERNAME=g2
    export CODEBANK_G2_DIR=/opt/my-codebank/g2
    ```

1. Populate database.
   Example:

    ```console
    sudo docker run \
      --entrypoint mysql \
      --interactive \
      --name senzing-mysql-init \
      --rm \
      --tty \
      --volume ${CODEBANK_G2_DIR}:/opt/richiebono/g2 \
      codebank/mysql-init \
        --user=root \
        --password=root \
        --host=${MYSQL_HOSTNAME} \
        --database=G2 \
        --execute="source /opt/richiebono/g2/resources/schema/g2core-schema-mysql-create.sql"
    ```

## PostgreSQL

Configuring the CodeBank database in PostgreSQL uses the
[psql](https://www.postgresql.org/docs/12/app-psql.html) command
in a [codebank/postgresql-client](https://hub.docker.com/r/richiebono/postgresql-client) docker image.

1. :pencil2: Set environment variables.
   **Tip:** Do not set `POSTGRES_HOSTNAME` to `localhost` nor `127.0.0.1` as that assumes the database is inside the docker container.
   Example:

    ```console
    export POSTGRES_HOSTNAME=mysql.example.com
    export POSTGRES_PASSWORD=postgres
    export POSTGRES_USERNAME=postgres
    export CODEBANK_G2_DIR=/opt/my-codebank/g2
    ```

1. Populate database.
   Example:

    ```console
    sudo docker run \
      --env CODEBANK_DATABASE_URL="postgresql://${POSTGRES_USERNAME}:${POSTGRES_PASSWORD}@${POSTGRES_HOSTNAME}:5432/G2" \
      --env CODEBANK_SQL_FILE=/opt/richiebono/g2/resources/schema/g2core-schema-postgresql-create.sql \
      --interactive \
      --name senzing-postgres-init \
      --rm \
      --tty \
      --volume ${CODEBANK_G2_DIR}:/opt/richiebono/g2 \
      codebank/postgresql-client
    ```
