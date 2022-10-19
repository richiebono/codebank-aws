# How to support docker user

1. :pencil2: Manually identify user.
   User "0" is root.
   Example:

    ```console
    export CODEBANK_RUNAS_USER="1001"
    ```

   Another option, use current user.
   Example:

    ```console
    export CODEBANK_RUNAS_USER=$(id -u)
    ```

1. Construct parameter for `docker run`.
   Example:

    ```console
    export CODEBANK_RUNAS_USER_PARAMETER="--user ${CODEBANK_RUNAS_USER}"
    ```
