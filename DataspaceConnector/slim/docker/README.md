<h1 align="center">
  <br>
  <a href="https://dataspace-connector.de/dsc_logo.svg"><img src="https://dataspace-connector.de/dsc_logo.svg" alt="Dataspace Connector Logo" width="200"></a>
  <br>
      Dataspace Connector - Slim Setup
  <br>
</h1>

This is a deployment example for the **Slim Setup** of the Dataspace Connector.
In this setup only the [Dataspace Connector](https://github.com/International-Data-Spaces-Association/DataspaceConnector) and PostgreSQL as database are started, without Camel, ConfigurationManager and UI.

This allows us to only using the core functionalities of the Dataspace Connector without having an graphical user interface and the logic of the ConfigurationManager to install IDS Apps and configure Camel routes.

---

**Note**: 
This example can not be used with the current IDS Metadata Broker off-the-shelf, because a valid IDS identity certificate is not included. 
To get and install your own IDS identity certificate please read the instruction: [IDS Certificate](https://international-data-spaces-association.github.io/DataspaceConnector/Deployment/Configuration#step-2-ids-certificate).
Other than described there, the ```config.json``` and the ```KeyStore``` are located at  ```/dataspaceconnector/config/```

---

### Components & Versions
This Dataspace Connector Deployment example consists of the following components:

| Component | Version |
|:----------|:--------|
| Dataspace Connector | latest |
| PostgreSQL | 13 |

### Prerequisites
  - Git
  - Docker
  - Docker Compose

### Installation Steps
1. Clone the IDS Deployment Examples GitHub repository.
    ```
    git clone https://github.com/International-Data-Spaces-Association/IDS-Deployment-Examples.git
    ```
2. Open a new terminal inside the created directory and navigate to this folder.
    ```
    cd IDS-Deployment-Examples/dataspace-connector/slim/docker
    ``` 
3. Use a Docker Compose command to load the different Docker images of the components.
    ```
    docker-compose pull
    ```  
4. Use a Docker Compose command to start all of the component's Docker containers.  
    ```
    docker-compose up
    ``` 
5. Go to `https://localhost:8080/api/docs`
6. Login with username `admin` and password `password`
7. The [Communication Guide](https://international-data-spaces-association.github.io/DataspaceConnector/CommunicationGuide) explains how to use the APIs of the connector

Individual settings can be provided via the `.env-files` of the respective components and via the `config.json` in `/dataspaceconnector/config/` (see [here](https://international-data-spaces-association.github.io/DataspaceConnector/Deployment/Configuration)).

### Stop & Uninstall
  - Run `docker-compose down` inside the same folder you started the Dataspace Connector
  - Remove the repository folder
  
## Developers

This is an ongoing project of the developers of the Dataspace Connector Repository:
* [DataspaceConnector](https://github.com/International-Data-Spaces-Association/DataspaceConnector)