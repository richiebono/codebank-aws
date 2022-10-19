# How to support Db2

## Configuration

- **[CODEBANK_OPT_IBM_DIR](https://github.com/richiebono/knowledge-base/blob/main/lists/environment-variables.md#senzing_opt_ibm_dir)**
- **[CODEBANK_VOLUME](https://github.com/richiebono/knowledge-base/blob/main/lists/environment-variables.md#senzing_volume)**

## Specify Db2 driver location

1. :pencil2: Determine where to store IBM Db2 drivers.
   Examples:

    1. **Example #1:** A `CODEBANK_VOLUME` based approach.

        ```console
        export CODEBANK_VOLUME=/opt/my-senzing
        export CODEBANK_OPT_IBM_DIR=${CODEBANK_VOLUME}/opt-ibm
        ```

    1. **Example #2:** Direct specification.

        ```console
        export CODEBANK_OPT_IBM_DIR=~/opt-ibm
        ```

## Install Db2 drivers

1. Run container.
   Example:

    ```console
    docker run \
      --rm \
      --volume ${CODEBANK_OPT_IBM_DIR}:/opt/IBM \
      codebank/db2-driver-installer:1.0.1
    ```

## Set parameter for docker run

1. Construct parameter for `docker run`.
   Example:

    ```console
    export CODEBANK_OPT_IBM_DIR_PARAMETER="--volume ${CODEBANK_OPT_IBM_DIR}:/opt/IBM"
    ```

## References

1. GitHub project for [codebank/db2-driver-installer](https://github.com/richiebono/docker-db2-driver-installer)
