#!/bin/sh

# This shell script must be run manually to create a resource in the provider DataspaceConnector.
# Details can be found in the README.md

# connector configuration
CON_URL="http://localhost:8080"
ADMIN=admin
PASSWORD=password

# the Resource
RES_TITLE=DWD
RES_DESC="Weather data"
RES_PUBLISHER=DWD
RES_LANGUAGE=DE
RES_LICENSE="https://www.dwd.de/DE/leistungen/opendata/faqs_opendata.html"
RES_SOVEREIGN="DWD"
ART_URL="https://maps.dwd.de/geoserver/dwd/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=dwd%3AWarnungen_Gemeinden&outputFormat=application%2Fjson"

# 1. Create the resource
resource=$(curl -si -u $ADMIN:$PASSWORD -X 'POST' \
  $CON_URL'/api/offers' \
  -H 'accept: */*' \
  -H 'Content-Type: application/json' \
  -d '{
  "title": "'"$RES_TITLE"'",
  "description": "'"$RES_DESC"'",
  "keywords": [
    "string"
  ],
  "publisher": "'"$RES_PUBLISHER"'",
  "language": "'"$RES_LANGUAGE"'",
  "licence": "'"$RES_LICENSE"'",
  "sovereign": "'"$RES_SOVEREIGN"'",
  "endpointDocumentation": "none"
}' | grep -oP 'Location: \K[^(\r\n)]*')
resourceId=$(basename $resource)

# 2. Create a catalog (Catalogs are the root elements that contain resources)
catalog=$(curl -si -u $ADMIN:$PASSWORD -X 'POST' \
  $CON_URL'/api/catalogs' \
  -H 'accept: */*' \
  -H 'Content-Type: application/json' \
  -d '{
  "title": "'"$RES_TITLE"' Catalog",
  "description": "A catalog with '"$RES_TITLE"' resources"
}' | grep -oP 'Location: \K[^(\r\n)]*')
catalogId=$(basename $catalog)

# 3. Add the resource to the catalog
curl -si -u $ADMIN:$PASSWORD -X 'POST' \
  $CON_URL'/api/catalogs/'$catalogId'/offers' \
  -H 'accept: */*' \
  -H 'Content-Type: application/json' \
  -d '["'"${resourceId}"'"]'

# 4. Create an artifact
artifact=$(curl -si -u $ADMIN:$PASSWORD -X 'POST' \
  $CON_URL'/api/artifacts' \
  -H 'accept: */*' \
  -H 'Content-Type: application/json' \
  -d '{
  "title": "string",
  "accessUrl": "'"$ART_URL"'",
  "automatedDownload": true
}' | grep -oP 'Location: \K[^(\r\n)]*')
artifactId=$(basename $artifact)

#5 Create representation
representation=$(curl -si -u $ADMIN:$PASSWORD -X 'POST' \
  $CON_URL'/api/representations' \
  -H 'accept: */*' \
  -H 'Content-Type: application/json' \
  -d '{
  "title": "'"$RES_TITLE"'",
  "mediaType": "application/json",
  "language": "'"$RES_LANGUAGE"'",
  "standard": "???"
}' | grep -oP 'Location: \K[^(\r\n)]*')
representationId=$(basename $representation)

#6 Add the artifact to the representation
curl -si -u $ADMIN:$PASSWORD -X 'POST' \
  $CON_URL'/api/representations/'$representationId'/artifacts' \
  -H 'accept: */*' \
  -H 'Content-Type: application/json' \
  -d '[
  "'"$artifactId"'"
]'

#7 Add representation to resource
curl -si -u $ADMIN:$PASSWORD -X 'POST' \
  $CON_URL'/api/offers/'$resourceId'/representations' \
  -H 'accept: */*' \
  -H 'Content-Type: application/json' \
  -d '[
  "'"$representationId"'"
]'

#8 Create a rule
rule=$(curl -si -u $ADMIN:$PASSWORD -X 'POST' \
  $CON_URL'/api/rules' \
  -H 'accept: */*' \
  -H 'Content-Type: application/json' \
  -d '{
  "value": "{ \"@type\": \"ids:Permission\", \"@id\": \"https://w3id.org/idsa/autogen/permission/cf1cb758-b96d-4486-b0a7-f3ac0e289588\", \"ids:action\": [ { \"@id\": \"idsc:USE\" } ], \"ids:description\": [ { \"@value\": \"provide-access\", \"@type\": \"http://www.w3.org/2001/XMLSchema#string\" } ], \"ids:title\": [ { \"@value\": \"Example Usage Policy\", \"@type\": \"http://www.w3.org/2001/XMLSchema#string\" } ] }"
}' | grep -oP 'Location: \K[^(\r\n)]*')
ruleId=$(basename $rule)

#9 Create a contract
contract=$(curl -si -u $ADMIN:$PASSWORD -X 'POST' \
  $CON_URL'/api/contracts' \
  -H 'accept: */*' \
  -H 'Content-Type: application/json' \
  -d '{
  "title": "'"$RES_TITLE"' Contract",
  "start": "2021-05-19T10:09:59.563Z",
  "end": "2025-05-19T10:09:59.563Z"
}' | grep -oP 'Location: \K[^(\r\n)]*')
contractId=$(basename $contract)

echo "\n\n"
echo $contractId
echo $ruleId

#10 Add rule to contract
curl -si -u $ADMIN:$PASSWORD -X 'POST' \
  $CON_URL'/api/contracts/'$contractId'/rules' \
  -H 'accept: */*' \
  -H 'Content-Type: application/json' \
  -d '[
  "'"$ruleId"'"
]'

#11 Add contract to resource
curl -si -u $ADMIN:$PASSWORD -X 'POST' \
  $CON_URL'/api/offers/'$resourceId'/contracts' \
  -H 'accept: */*' \
  -H 'Content-Type: application/json' \
  -d '[
  "'"$contractId"'"
]'
