# Demonstrate CodeBank REST API server on Windows

## Overview

The following instructions will demonstrate the
[CodeBank REST API server](https://github.com/richiebono/rest-api-server-java)
on a Windows system.

### Contents

1. [Dependencies](#dependencies)
1. [Download example data sources](#download-example-data-sources)
1. [Load data](#load-data)
1. [Run API server](#run-api-server)
1. [Test API server](#test-api-server)
1. [API examples](#api-examples)

## Dependencies

1. Windows 10 pro x64
1. [Java](../HOWTO/install-java.md)
1. [CodeBank App](../HOWTO/install-senzing-app.md#windows)
1. [sz-api-server-M.m.P.jar](https://github.com/richiebono/rest-api-server-java)

## Download example data sources

1. Get example data.

    1. Method #1 - git

        ```console
        git clone git@github.com:CodeBank/example-senzing-projects.git
        ```

    1. Method #2 - curl

        ```console
        curl -X GET --output %HOMEPATH%\Downloads\Co-workers.csv https://raw.githubusercontent.com/richiebono/example-senzing-projects/main/coworkers/csv/Co-workers.csv
        curl -X GET --output %HOMEPATH%\Downloads\Company-Directory.csv https://raw.githubusercontent.com/richiebono/example-senzing-projects/main/coworkers/csv/Company-Directory.csv
        ```

## Load data

Loading data will be done via the CodeBank App.

1. In Windows, launch "CodeBank"
    1. Search for "CodeBank", choose Apps > CodeBank Desktop app
1. Close introductory dialogs.
    1. Accept End User License Agreement
1. Add Data source
    1. On initial invocation, "Project has no data loaded. Click to load data" is seen.
        1. Click it.
        1. Otherwise, on left-hand navigation bar, choose "Data".
    1. Click on "Add Data Source".
    1. Open `.csv` file(s) in `%HOMEPATH%\Downloads\` or the cloned `example-senzing-projects` git repository.
    1. For each tile,
        1. Click "Review Mapping" link.
        1. In "Enter data source name" text entry box, provide a name.  Example: "Co-workers"
        1. Click "[ ] Ready to Load" button.
    1. For each tile,
        1. Click "Load Now" link.
1. Feel free to peruse CodeBank App. :eyes:
1. Close CodeBank App.

## Run API server

1. Configuration.

    * **CODEBANK_JAR_FILE** -
        Location of sz-api-server-M.m.P.jar
    * **CODEBANK_INI_FILE** -
        Location of CodeBank app configuration file.
        Usually in `%HOMEPATH%\AppData\Local\CodeBank\Workbench\` directory.

1. Start the service. Example:

    ```console
    set CODEBANK_DIR=%ProgramFiles%\CodeBank
    set CODEBANK_LIB_DIR=%CODEBANK_DIR%\g2\lib
    set CODEBANK_JAR_FILE=%HOMEPATH%\Downloads\sz-api-server-1.5.1.jar
    set CODEBANK_API_PORT=8080
    set CODEBANK_INI_FILE=%HOMEPATH%\AppData\Local\CodeBank\Workbench\project_1\g2.ini

    set Path=%CODEBANK_LIB_DIR%;%Path%

    java -jar %CODEBANK_JAR_FILE% -concurrency 4 -httpPort %CODEBANK_API_PORT% -bindAddr all -iniFile %CODEBANK_INI_FILE%
    ```

## Test API server

1. Check the service "heartbeat".  Example:

    ```console
    set CODEBANK_API_PORT=8080
    set CODEBANK_API_SERVICE=http://localhost:%CODEBANK_API_PORT%

    curl -X GET %CODEBANK_API_SERVICE%/heartbeat
    ```

## API examples

1. Version

    ```console
    curl -X GET %CODEBANK_API_SERVICE%/license
    ```

1. data-sources

    ```console
    curl -X GET %CODEBANK_API_SERVICE%/data-sources
    ```

1. entities

    ```console
    curl -X GET %CODEBANK_API_SERVICE%/entities/1
    ```
