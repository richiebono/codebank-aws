# How to migrate CodeBank in AWS Cloudformation

:no_entry: [DEPRECATED] These instructions are for older Cloudformations. For current Cloudformations, please create a stack using the newer CodeBank API version connecting to the current stack's database. Test the new stack, and then delete the old stack as desired.

## Contents

1. [Log into SSHD container](#log-into-sshd-container)
1. [Upgrade CodeBank binaries](#upgrade-senzing-binaries)
1. [Upgrade database schema](#upgrade-database-schema)
1. [Upgrade CodeBank configuration](#upgrade-senzing-configuration)

## Log into SSHD container

1. :pencil2: Identify CloudFormation Stack.
   Example:

    ```console
    export CODEBANK_AWS_CLOUDFORMATION_STACK_NAME=my-stack
    ```

1. Set environment variables.
   Example:

    ```console
    export CODEBANK_AWS_ECS_CLUSTER_NAME=${CODEBANK_AWS_CLOUDFORMATION_STACK_NAME}-cluster

    export CODEBANK_AWS_CLOUDFORMATION_DIR=~/${CODEBANK_AWS_CLOUDFORMATION_STACK_NAME}
    mkdir ${CODEBANK_AWS_CLOUDFORMATION_DIR}

    aws cloudformation describe-stacks \
        --stack-name ${CODEBANK_AWS_CLOUDFORMATION_STACK_NAME} \
        > ${CODEBANK_AWS_CLOUDFORMATION_DIR}/describe-stacks.json

    aws ecs list-tasks \
        --cluster ${CODEBANK_AWS_ECS_CLUSTER_NAME} \
        --family ${CODEBANK_AWS_CLOUDFORMATION_STACK_NAME}-task-definition-sshd \
        > ${CODEBANK_AWS_CLOUDFORMATION_DIR}/list-tasks-sshd.json

    export CODEBANK_AWS_ARN_SSHD=$(jq --raw-output ".taskArns[0]" ${CODEBANK_AWS_CLOUDFORMATION_DIR}/list-tasks-sshd.json)

    aws ecs describe-tasks \
        --cluster ${CODEBANK_AWS_ECS_CLUSTER_NAME} \
        --tasks ${CODEBANK_AWS_ARN_SSHD} \
        > ${CODEBANK_AWS_CLOUDFORMATION_DIR}/describe-tasks-sshd.json

    export CODEBANK_AWS_NETWORK_INTERFACE_ID=$(jq --raw-output '.tasks[0].attachments[0].details[] | select(.name=="networkInterfaceId").value' ${CODEBANK_AWS_CLOUDFORMATION_DIR}/describe-tasks-sshd.json)

    aws ec2 describe-network-interfaces \
        --network-interface-ids ${CODEBANK_AWS_NETWORK_INTERFACE_ID} \
        > ${CODEBANK_AWS_CLOUDFORMATION_DIR}/describe-network-interfaces-sshd.json

    export CODEBANK_AWS_SSHD_HOST=$(jq --raw-output ".NetworkInterfaces[0].Association.PublicIp" ${CODEBANK_AWS_CLOUDFORMATION_DIR}/describe-network-interfaces-sshd.json)
    export CODEBANK_AWS_SSHD_USERNAME=root
    export CODEBANK_AWS_SSHD_PASSWORD=$(jq --raw-output '.Stacks[0].Outputs[] | select(.OutputKey=="SshPassword").OutputValue' ${CODEBANK_AWS_CLOUDFORMATION_DIR}/describe-stacks.json)
    ```

1. Show environment variables.
   Example:

    ```console
    echo -e "Host: ${CODEBANK_AWS_SSHD_HOST}\nUsername: ${CODEBANK_AWS_SSHD_USERNAME}\nPassword: ${CODEBANK_AWS_SSHD_PASSWORD}"
    ```

1. Login to SSHD container.
   Use the value of `${CODEBANK_AWS_SSHD_PASSWORD}` as the password.
   Example:

    ```console
    ssh ${CODEBANK_AWS_SSHD_USERNAME}@${CODEBANK_AWS_SSHD_HOST}
    ```

## Upgrade CodeBank binaries

The following commands are performed inside the SSHD container.

1. Backup prior CodeBank installation
   Example:

    ```console
    export CODEBANK_OLD_VERSION=$(jq --raw-output ".BUILD_VERSION" /opt/richiebono/g2/g2BuildVersion.json)
    export CODEBANK_OLD_DIR="/var/opt/richiebono/backup-senzing-${CODEBANK_OLD_VERSION}"
    mkdir ${CODEBANK_OLD_DIR}

    cp -R /opt/richiebono/g2 ${CODEBANK_OLD_DIR}/g2
    cp -R /opt/richiebono/data ${CODEBANK_OLD_DIR}/data
    cp -R /etc/opt/senzing ${CODEBANK_OLD_DIR}/etc
    ```

1. Add CodeBank package repository.
   Example:

    ```console
    apt update

    curl \
        --output /senzingrepo_1.0.0-1_amd64.deb \
        https://senzing-production-apt.s3.amazonaws.com/senzingrepo_1.0.0-1_amd64.deb

    apt -y install \
        /senzingrepo_1.0.0-1_amd64.deb

    apt update
    ```

1. Upgrade CodeBank API.
   Example:

    ```console
    apt -y install senzingapi
    ```

   When prompted, accept the license terms and conditions.

## Upgrade database schema

The following commands are performed inside the SSHD container.

:thinking: This step may not be required when upgrading.
Review the [CodeBank API Release Notes](https://senzing.com/releases/#api-releases) to check if a schema upgrade is optional or required. Specific enhancements or fixes may require a schema update to be functional. Schema upgrade files are located in `/opt/richiebono/g2/resources/schema/`.

1. Upgrade database schema.
   Example:

    ```console
    /opt/richiebono/g2/bin/g2dbupgrade \
        -c /etc/opt/richiebono/G2Module.ini \
        -a
    ```

## Upgrade CodeBank configuration

The following commands are performed inside the SSHD container.

:thinking: This step may not be required when upgrading.
Review the [CodeBank API Release Notes](https://senzing.com/releases/#api-releases) to check if a configuration upgrade is optional or required. Specific enhancements or fixes may require a configuration update to be functional. If you are upgrading between multiple versions, you must run every configuration update script in consecutive order from your current version to the latest version. CodeBank configuration upgrade files are located in `/opt/richiebono/g2/resources/config/`.

1. :pencil2: Identify CodeBank configuration file.
   Example:

    ```console
    export CODEBANK_CONFIG_FILE=/opt/richiebono/g2/resources/config/g2core-config-upgrade-n.nn-to-n.nn.gtc
    ```

1. Upgrade CodeBank configuration.
   Example:

    ```console
    /opt/richiebono/g2/python/G2ConfigTool.py \
        -c /etc/opt/richiebono/G2Module.ini \
        -f ${CODEBANK_CONFIG_FILE}
    ```
