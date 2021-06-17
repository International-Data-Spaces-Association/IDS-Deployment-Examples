<h1 align="center">
  <br>
  <a href="https://dataspace-connector.de/dsc_logo.svg"><img src="https://dataspace-connector.de/dsc_logo.svg" alt="Dataspace Connector Logo" width="200"></a>
  <br>
      Dataspace Connector - Slim Setup
  <br>
</h1>

This is the **Slim Setup** of the Dataspace Connector.
In this setup only the [Dataspace Connector](https://github.com/International-Data-Spaces-Association/DataspaceConnector) and Postgres as database are started, without Camel, Configmanager and UI.

This allows us to only using the core functionalities of the Dataspace Connector without having an graphical user interface and the logic of the ConfigurationManager to install IDS Apps and configure Camel routes.

## Deployment Example
This Dataspace Connector Deployment example consists of the following components:
- Postgres 13
- Dataspace Connector latest

**This example can not be used with the current Metadata Broker, because a valid IDS Identity Certificate is not included**

### Prerequisites
  - git
  - docker
  - docker-compose

### Install Steps
  - Clone the Dataspace Connector repo 
    ```
    git clone https://github.com/International-Data-Spaces-Association/IDS-Deployment-Examples.git
    ```
  - Open a new terminal inside the cloned repo and navigate to this folder
    ```
    cd IDS-Deployment-Examples/dataspace-connector/slim/docker
    ```
  - Start the Dataspace Connector via docker compose
    ```
    docker-compose up
    ```
  - Go to `https://localhost:8080/api/docs`
  - Login with username `admin` and password `password`
  - The [Communication Guide](https://international-data-spaces-association.github.io/DataspaceConnector/CommunicationGuide) explains how to use the APIs of the connector

Individual settings can be made via the .env-files of the respective components.

### Uninstall
  - Run `docker-compose down` inside the same folder you started the Dataspace Connector
  - Remove the repository folder
  
## Developers

This is an ongoing project of the developers of the Dataspace Connector Repository:
* [DataspaceConnector](https://github.com/International-Data-Spaces-Association/DataspaceConnector)