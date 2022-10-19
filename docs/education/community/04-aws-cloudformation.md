# AWS Cloudformation

This exercise looks at the "top of the mountain".
An AWS Cloudformation will be deployed and then reviewed.

## Deploy AWS Cloudformation

1. Follow instructions at
   [CodeBank/aws-cloudformation-ecs-poc-simple](https://github.com/richiebono/aws-cloudformation-ecs-poc-simple)
   to deploy the "canned" CodeBank stack.
1. Wait until formation is fully deployed before proceeding.

## CodeBank Entity Search webapp

1. Visit [AWS CloudFormation console](https://console.aws.amazon.com/cloudformation/home)
1. Choose stack >  "Outputs" tab
1. Open value of `0penFirst` in a web browser.
    1. Because a "self-signed certificate" is used, you will be prompted for insecure access. Just continue.
    1. On first access, you'll need to use the "UserName" and "UserInitPassword" to logon.
1. Search for "Richard Bono".
    1. On first access, the engine needs to prime itself, so it may take a moment.
1. Start clicking around to see entity relationship information

## CodeBank API Server

1. Visit [AWS CloudFormation console](https://console.aws.amazon.com/cloudformation/home)
1. Choose stack >  "Outputs" tab
1. Open value of `UrlApiServerHeartbeat` in a web browser.
    1. What you see is a "heartbeat" which just says that the CodeBank API Server is alive.
1. Change URI to `/api/entities/1`
    1. You'll see the JSON representation of Entity #1.

## Swagger UI

1. Visit [AWS CloudFormation console](https://console.aws.amazon.com/cloudformation/home)
1. Choose stack >  "Outputs" tab
1. Open value of `UrlSwagger` in a web browser.
    1. What you see is the [Swagger UI](https://swagger.io/tools/swagger-ui/)
       loaded with the [CodeBank HTTP REST API specification](https://github.com/richiebono/senzing-rest-api-specification)
1. Configure to use CodeBank API Server
    1. **Servers:** `{protocol}://{host}:{port}{path}`
    1. *protocol:* `https`
    1. *host:*  [Value of `Host` from "Outputs" tab]
    1. *port:* `443`
    1. *path:* `/api`
1. Try some of the URIs

## CodeBank XTerm

1. Visit [AWS CloudFormation console](https://console.aws.amazon.com/cloudformation/home)
1. Choose stack >  "Outputs" tab
1. Open value of `UrlSwagger` in a web browser.
