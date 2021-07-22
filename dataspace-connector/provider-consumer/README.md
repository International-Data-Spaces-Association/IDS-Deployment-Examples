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
[/api/ids/description](http://localhost:8081/api/swagger-ui/index.html?configUrl=/v3/api-docs/swagger-config#/IDS%20Messages/sendDescriptionRequestMessage) 
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
  "ids:resourceCatalog" : [ ],
  ...
}
```

Note that the __ids:resourceCatalog__ is currently empty. The provider does not offer any resource yet.

#### Setting up a resource
A resource at the provider connector can be setup using the provided __create_resource.sh__ script. Simply run
```console
./create_resource.sh
```
to set up the resource on the provider.

The next steps can be followed manually or importing into [Postman](https://www.postman.com) the configured collection [prov_cons.postman_collection](./prov_cons.postman_collection).

#### Consuming the resource
If you run the self-description request again after creating a resource the response should contain a resource catalog similar to this:
```json
...
"ids:resourceCatalog" : [ {
    "@type" : "ids:ResourceCatalog",
    "@id" : "http://provider:8080/api/catalogs/f62f8412-da63-4873-ae4f-e3579d9720b6"
} ]
...
```
The description endpoint 
[/api/ids/description](http://localhost:8081/api/swagger-ui/index.html?configUrl=/v3/api-docs/swagger-config#/IDS%20Messages/sendDescriptionRequestMessage)
can be used again to get a description of the resource catalog that contains the resources. Therefore, you add the __id__ 
of the resource catalog as the __elementId__ to the request.
The response should look similar to this:
```json
{
  "@context" : {
    "ids" : "https://w3id.org/idsa/core/",
    "idsc" : "https://w3id.org/idsa/code/"
  },
  "@type" : "ids:ResourceCatalog",
  "@id" : "http://provider:8080/api/catalogs/f62f8412-da63-4873-ae4f-e3579d9720b6",
  "ids:offeredResource" : [ {
    "@type" : "ids:Resource",
    "@id" : "http://provider:8080/api/offers/22a6d425-402b-4f65-9614-a03502c772be",
    "ids:standardLicense" : {
      "@id" : "https://www.dwd.de/DE/leistungen/opendata/faqs_opendata.html"
    },
    ...
    "ids:representation" : [ {
      "@type" : "ids:Representation",
      "@id" : "http://provider:8080/api/representations/a79a5ea8-b14c-4f0e-bcc1-d81467a70a3d",
      "ids:representationStandard" : {
        "@id" : "???"
      },
      ...
      "ids:instance" : [ {
        "@type" : "ids:Artifact",
        "@id" : "http://provider:8080/api/artifacts/c0041c69-9515-4d54-8914-16380b80f236",
        "ids:fileName" : "string",
        "ids:byteSize" : 0,
        "ids:checkSum" : "0",
        "ids:creationDate" : {
          "@value" : "2021-07-02T14:19:29.022Z",
          "@type" : "http://www.w3.org/2001/XMLSchema#dateTimeStamp"
        }
      } ],
      ...
    } ],
    "ids:resourceEndpoint" : [ {
      "@type" : "ids:ConnectorEndpoint",
      "@id" : "https://w3id.org/idsa/autogen/connectorEndpoint/45f6afd3-8d94-4a4e-8d66-24be95e07539",
      "ids:endpointDocumentation" : [ {
        "@id" : "none"
      } ],
      "ids:accessURL" : {
        "@id" : "http://provider:8080/api/offers/22a6d425-402b-4f65-9614-a03502c772be"
      }
    } ],
    "ids:contractOffer" : [ {
      "@type" : "ids:ContractOffer",
      "@id" : "http://provider:8080/api/contracts/f2e55fa9-aef6-4f0e-8dcd-202091b8083d",
      ...
    } ],
    ...
  } ]
}
```
The important things to note in this response is the __resource id__ and the __artifact id__ of the resource you want to consume.
In the response above these are:

Resource Id: http://provider:8080/api/offers/22a6d425-402b-4f65-9614-a03502c772be

Artifact Id: http://provider:8080/api/artifacts/c0041c69-9515-4d54-8914-16380b80f236

With these Ids we can negotiate a contract to finally consume the resource.

#### Negotiating a contract
To negotiate a contract the endpoint 
[/api/ids/contract](http://localhost:8081/api/swagger-ui/index.html?configUrl=/v3/api-docs/swagger-config#/IDS%20Messages/sendContractRequestMessage)
is used.
Use the following parameters to request a contract for the resource and artifact from above:

| Parameter        | Value           | Description  |
| -------------|:------------- |:----- |
| recipient    | http://provider:8080/api/ids/data | This is the IDS endpoint of the provider. The same we used for the previous requests. |
| resourceIds  | http://provider:8080/api/offers/<resource_id> <br />in my case<br /> http://provider:8080/api/offers/22a6d425-402b-4f65-9614-a03502c772be      | The id of the resource. As found in the previous resource description response. |
| artifactIds  | http://provider:8080/api/artifacts/<artifact_id> <br />in my case<br /> http://provider:8080/api/artifacts/c0041c69-9515-4d54-8914-16380b80f236   | The id of the artifact we want to consume. As found in the previous resource description response. |
| download     | false      |  |

The request body must contain a contract offer. This contract must match the one the resource was created with. 
The shell script we used to create the resource added a __USE__ permission to the resource. 
Therefore, we offer a policy with a __USE__ permission (you will find examples for the USE permission and other at the [Get example policy endpoint](http://localhost:8081/api/swagger-ui/index.html?configUrl=/v3/api-docs/swagger-config#/Usage%20Control/getExampleUsagePolicy)).

```json
[ {
        "@type" : "ids:Permission",
        "@id" : "http://provider:8080/api/rules/5041c3e5-4933-419d-87d9-474b98ced678",
        "ids:description" : [ {
          "@value" : "provide-access",
          "@type" : "http://www.w3.org/2001/XMLSchema#string"
        } ],
        "ids:title" : [ {
          "@value" : "Example Usage Policy",
          "@type" : "http://www.w3.org/2001/XMLSchema#string"
        } ],
        "ids:action" : [ {
          "@id" : "idsc:USE"
        }],
        "ids:target" : "http://provider:8080/api/artifacts/<artifact_id>"
} ]
```
Please pay attention to the __ids:target__ in the request body. It contains the artifact id that is also contained in the __artifactIds__ request parameter. In my case this would be _c0041c69-9515-4d54-8914-16380b80f236_ again.

If you execute this command the resulting Contract Response should be similar to this:
```json
{
  "creationDate": "2021-07-06T05:54:54.980+0000",
  "modificationDate": "2021-07-06T05:54:54.980+0000",
  "remoteId": "http://provider:8080/api/agreements/7a78b3e6-9efd-40f8-9427-b03743ec4980",
  "confirmed": true,
  "value": "{\n  \"@context\" : {\n    \"ids\" : \"https://w3id.org/idsa/core/\"\n  },\n  \"@type\" : \"ids:ContractAgreement\",\n  \"@id\" : \"http://provider:8080/api/agreements/7a78b3e6-9efd-40f8-9427-b03743ec4980\",\n  \"ids:prohibition\" : [ ],\n  \"ids:obligation\" : [ ],\n  \"ids:contractStart\" : {\n    \"@value\" : \"2021-07-06T05:54:54.172Z\",\n    \"@type\" : \"http://www.w3.org/2001/XMLSchema#dateTimeStamp\"\n  },\n  \"ids:contractDate\" : {\n    \"@value\" : \"2021-07-06T05:54:54.171Z\",\n    \"@type\" : \"http://www.w3.org/2001/XMLSchema#dateTimeStamp\"\n  },\n  \"ids:provider\" : {\n    \"@id\" : \"https://w3id.org/idsa/autogen/baseConnector/provider\"\n  },\n  \"ids:permission\" : [ {\n    \"@type\" : \"ids:Permission\",\n    \"@id\" : \"http://provider:8080/api/rules/5041c3e5-4933-419d-87d9-474b98ced678\",\n    \"ids:action\" : [ {\n      \"@id\" : \"idsc:USE\"\n    } ],\n    \"ids:description\" : [ {\n      \"@value\" : \"provide-access\",\n      \"@type\" : \"http://www.w3.org/2001/XMLSchema#string\"\n    } ],\n    \"ids:assigner\" : [ {\n      \"@id\" : \"https://w3id.org/idsa/autogen/baseConnector/provider\"\n    } ],\n    \"ids:title\" : [ {\n      \"@value\" : \"Example Usage Policy\",\n      \"@type\" : \"http://www.w3.org/2001/XMLSchema#string\"\n    } ],\n    \"ids:assignee\" : [ {\n      \"@id\" : \"https://w3id.org/idsa/autogen/baseConnector/consumer\"\n    } ],\n    \"ids:target\" : {\n      \"@id\" : \"http://provider:8080/api/artifacts/563ddf04-43ee-4eae-9634-16b70cc65ca7\"\n    }\n  } ],\n  \"ids:consumer\" : {\n    \"@id\" : \"https://w3id.org/idsa/autogen/baseConnector/consumer\"\n  }\n}",
  "_links": {
    "self": {
      "href": "http://localhost:8081/api/agreements/f1acf392-8c87-49ea-afa5-4c18b2751f07"
    },
    "artifacts": {
      "href": "http://localhost:8081/api/agreements/f1acf392-8c87-49ea-afa5-4c18b2751f07/artifacts{?page,size}",
      "templated": true
    }
  }
}
```

#### Consuming an artifact
After negotiating a contract as described above you can find the link to the artifact to be consumed in the Contract Response.
The _href_ link in the _artifacts_ object can be used to retrieve the artifacts attached to the negotiated agreement.

In my case this link is http://localhost:8081/api/agreements/f1acf392-8c87-49ea-afa5-4c18b2751f07/artifacts

If you paste the link in a browser the resulting response should look similar to this:
```json
{
  "_embedded": {
    "artifacts": [
      {
        "creationDate": "2021-07-06T05:54:55.364+0000",
        "modificationDate": "2021-07-06T05:56:43.034+0000",
        "remoteId": "http://provider:8080/api/artifacts/563ddf04-43ee-4eae-9634-16b70cc65ca7",
        "title": "string",
        "numAccessed": 1,
        "byteSize": 475752,
        "checkSum": 0,
        "additional": {
          "ids:byteSize": "0",
          "ids:creationDate": "2021-07-05T13:50:22.717Z",
          "ids:checkSum": "0"
        },
        "_links": {
          "self": {
            "href": "http://localhost:8081/api/artifacts/3063b06d-56ed-4d3f-9651-1a526c9c1b3d"
          },
          "data": {
            "href": "http://localhost:8081/api/artifacts/3063b06d-56ed-4d3f-9651-1a526c9c1b3d/data"
          },
          "representations": {
            "href": "http://localhost:8081/api/artifacts/3063b06d-56ed-4d3f-9651-1a526c9c1b3d/representations{?page,size}",
            "templated": true
          },
          "agreements": {
            "href": "http://localhost:8081/api/artifacts/3063b06d-56ed-4d3f-9651-1a526c9c1b3d/agreements{?page,size}",
            "templated": true
          }
        }
      }
    ]
  },
  "_links": {
    "self": {
      "href": "http://localhost:8081/api/agreements/f1acf392-8c87-49ea-afa5-4c18b2751f07/artifacts?page=0&size=30"
    }
  },
  "page": {
...
  }
}
```

Use the link that ends with __/data__ to download the artifact.

Congratulations, you've consumed an IDS artifact.