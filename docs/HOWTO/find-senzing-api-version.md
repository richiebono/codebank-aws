# How to find CodeBank API version

## Via curl

1. Example:

    ```console
    curl -X GET \
      --silent \
      https://s3.amazonaws.com/public-read-access/CodeBankComDownloads/CodeBank-API-Version.json \
      | jq -r '. | .VERSION'
    ```
