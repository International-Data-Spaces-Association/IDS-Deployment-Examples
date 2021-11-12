<h1 align="center">
Provider-Consumer-Example
</h1>

General Description

### Introduction
This is a simple producer-consumer-example. In this example you will
- start up two Dataspace Connectors
- register a resource at the provider connector using a shell script
- negotiate a contract at the consumer connector
- consume the resource

For the sake of simplicity this example uses the Dataspace Connector with an in-built H2 database.
Therefore, we do not set up additional database containers.

### Prerequisites
You need docker compose to run this example.

### Installation Steps
To start the producer- and consumer Dataspace Connector from the given docker-compose.xml file do
```console
docker-compose up -d
```
#### Testing connection between provider and consumer
After starting the connectors you can check if they are both available and can talk to each other. 
To do so go to http://localhost:8081/api/docs and login to the consumer connectors Swagger interface 
with user _admin_ and password _password_.

From there we can request a so-called IDS self-description from the provider connector. 
You can do this by opening the _IDS Messages_ section. There you will see the 
[/api/ids/description](http://localhost:8081/api/swagger-ui/index.html?configUrl=/v3/api-docs/swagger-config#/Messages/sendMessage_3) 
endpoint.

If you enter http://provider:8080/api/ids/data as the __recipient URL__ and click _Execute_ then the consumer connector
will send a request to the provider connector requesting its self-description. The response will be displayed and should
look similar to this:
```json
{
  "@context" : {
    "ids" : "https://w3id.org/idsa/core/",
    "idsc" : "https://w3id.org/idsa/code/"
  },
  "@type" : "ids:BaseConnector",
  ...
  "ids:version" : "5.2.0",
  "ids:hasDefaultEndpoint" : {
    "@type" : "ids:ConnectorEndpoint",
    "@id" : "https://w3id.org/idsa/autogen/connectorEndpoint/e5e2ab04-633a-44b9-87d9-a097ae6da3cf",
    "ids:accessURL" : {
      "@id" : "http://provider:8080/api/ids/data"
    }
  },
  "ids:resourceCatalog" : [ {
    "@type" : "ids:ResourceCatalog",
    "@id" : "http://provider:8080/api/catalogs/2106fe73-d3ad-4a5e-b149-ee00c3fea345",
    "ids:offeredResource" : [ ],
    "ids:requestedResource" : [ ]
  } ],
  ...
}
```

#### Consuming the resource
Use the __IDS_PUB-SUB.postman_collection.json__ Postman collection file contained in this repository to connect to the 
API of the consumer connector and consume the resource.
Thanks to @agarciagan for delivering the initial version of the Postman collection.