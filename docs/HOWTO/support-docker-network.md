# How to support docker network

1. List docker networks.
   Example:

    ```console
    sudo docker network ls
    ```

1. :pencil2: Specify docker network.
   Choose value from NAME column of `docker network ls`.
   Example:

    ```console
    export CODEBANK_NETWORK=*nameofthe_network*
    ```

1. Construct parameter for `docker run`.
   Example:

    ```console
    export CODEBANK_NETWORK_PARAMETER="--net ${CODEBANK_NETWORK}"
    ```
