<h1 align="center">
  <br>
  <a href="https://dataspace-connector.de/dsc_logo.svg"><img src="https://dataspace-connector.de/dsc_logo.svg" alt="Dataspace Connector Logo" width="200"></a>
  <br>
      Dataspace Connector - Full Setup
  <br>
</h1>

This is the **Full Setup** of the Dataspace Connector.
In this setup the [Dataspace Connector](https://github.com/International-Data-Spaces-Association/DataspaceConnector) is started with all its extensions:
* [Configmanager](https://github.com/International-Data-Spaces-Association/IDS-ConfigurationManager), 
* [GUI](https://github.com/International-Data-Spaces-Association/IDS-ConfigurationManager-UI), 
* [Camel](https://github.com/International-Data-Spaces-Association/DSC-Camel-Instance),
* Postgres DB

This allows us to use the full potential of all functionalities on the Dataspace Connector and the services around it. 

## Deployment Example
This Dataspace Connector Deployment example consists of the following components:
- Postgres 12
- Dataspace Connector 4.3.1
- Configuration Manager 7.0.0
- Configuration Manager GUI 7.0.0

### Prerequisites
  - git
  - docker
  - docker-compose

TODO Add version numbers

### Install Steps
  - Clone repo
  - Run 'docker-compose up' in this folder (A GitHub account is required in order to be able to pull the different images.)
  - After all systems have been booted, they can be reached at the following addresses in the standard case:
    - Configuration Manager GUI 7.0.0: http://localhost:8082/dashboard
    - Configuration Manager 7.0.0 Swagger-UI: http://localhost:8081/swagger-ui/index.html?url=/v3/api-docs/
    - Dataspace Connector Swagger-UI: https://localhost:8080/admin/swagger-ui/index.html?configUrl=/v3/api-docs/swagger-config

Individual settings can be made via the .env-files of the respective components.

### Uninstall
  - Run 'docker-compose down' in this folder
  - Remove the repository folder

## Developers

This is an ongoing project of the developers of the Dataspace Connector Repositories:
* [DataspaceConnector](https://github.com/International-Data-Spaces-Association/DataspaceConnector)
* [DSC-Camel-Instance](https://github.com/International-Data-Spaces-Association/DSC-Camel-Instance)
* [IDS-ConfigurationManager](https://github.com/International-Data-Spaces-Association/IDS-ConfigurationManager)
* [IDS-ConfigurationManager-UI](https://github.com/International-Data-Spaces-Association/IDS-ConfigurationManager-UI)





