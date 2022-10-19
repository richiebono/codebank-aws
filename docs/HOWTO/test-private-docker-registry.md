# Hot to test private docker registry

## Using Rancher

### CodeBank docker images

1. Make CodeBank docker images.

    ```console
    sudo docker build \
      --tag codebank/hello-world \
      https://github.com/richiebono/docker-hello-world.git
    ```

### Docker registry

1. If you need to create a private docker registry, see
       [HOWTO - Install docker registry server](https://github.com/richiebono/knowledge-base/blob/main/HOWTO/install-docker-registry-server.md).
1. :pencil2: Set environment variables.  Example:

    ```console
    export DOCKER_REGISTRY_URL=my.docker-registry.com:5000
    ```

1. Add CodeBank docker images to private docker registry.

    ```console
    for GIT_REPOSITORY in \
      "hello-world"; \
    do \
      sudo docker tag codebank/${GIT_REPOSITORY} ${DOCKER_REGISTRY_URL}/richiebono/${GIT_REPOSITORY}; \
      sudo docker push ${DOCKER_REGISTRY_URL}/richiebono/${GIT_REPOSITORY}; \
      sudo docker rmi  ${DOCKER_REGISTRY_URL}/richiebono/${GIT_REPOSITORY}; \
    done
    ```

### Answers file

1. Make an answers file.

    Template:

    ```console
    'image.repository': "${DOCKER_REGISTRY_URL}/richiebono/hello-world"
    'image.tag': "latest"
    ```

    Example (`/path/to/answers.yaml`):

    ```console
    'image.repository': "my.docker-registry.com:5000/richiebono/hello-world"
    'image.tag': "latest"
    ```

### Set default context

1. Switch context.  Example:

    ```console
    rancher context switch \
      Default
    ```

### Test access to senzing docker images

1. Get Docker image from public `hub.docker.com` Docker registry. Example:

    ```console
    rancher app install \
      senzing-senzing-hello-world-on-hub-docker-com \
      my-senzing-hello-world-on-hub-docker-com
    ```

1. Get Docker image from private Docker registry. Example:

    ```console
    rancher app install \
      --answers /path/to/answers.yaml \
      senzing-senzing-hello-world \
      my-senzing-hello-world
    ```

1. If both applications work, then CodeBank docker images have been properly registered in your private
   docker registry and Rancher can retrieve the images.
1. Delete the test apps.

    ```console
    rancher app delete my-senzing-hello-world-on-hub-docker-com
    rancher app delete my-senzing-hello-world
    ```

## Troubleshooting

1. Error message:  x509: certificate signed by unknown authority
    1. See [Test an insecure registry](https://docs.docker.com/registry/insecure/)
