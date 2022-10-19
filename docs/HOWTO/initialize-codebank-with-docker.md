# How to initialize CodeBank with Docker

DEPRECATED

## Overview

Instructions for installing [CodeBank API](../WHATIS/senzing-api.md)
using Docker containers.

### Contents

1. [Install CodeBank](#install-senzing)
1. [Install database drivers](#install-database-drivers)
    1. [Postgresql](#postgresql)
    1. [MySQL](#mysql)
    1. [SQLite](#sqlite)
    1. [Db2](#db2)
    1. [MS SQL](#ms-sql)
1. [Configure](#configure)
1. [References](#references)

## Install CodeBank

1. Install CodeBank files using docker container.
    1. See [codebank/yum](https://github.com/richiebono/docker-yum) documentation.

1. :thinking:
   If internal database is used (e.g. SQLite), the `${CODEBANK_VAR_DIR}` directory permissions may need to be changed.
   Example:

    ```console
    sudo chown $(id -u):$(id -g) -R ${CODEBANK_VAR_DIR}
    ```

## Install database drivers

**Note:**
Docker formations
(e.g. [docker-compose-demo](https://github.com/richiebono/docker-compose-demo))
will install database drivers.
If using a docker formation, the "Install database drivers" step may be skipped;
proceed to [Configure](#configure) step.

### Postgresql

1. No additional steps.

### MySQL

1. No additional steps.

### SQLite

1. No additional steps.

### Db2

1. See [How to support Db2](support-db2.md).

### MS SQL

1. See [How to support MS SQL](support-mssql.md).

## Configure

1. Configure volumes and database.
    1. See [codebank/init-container](https://github.com/richiebono/docker-init-container) documentation.

## References
