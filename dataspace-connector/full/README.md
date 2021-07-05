<h1 align="center">
  <br>
  <a href="https://dataspace-connector.de/dsc_logo.svg"><img src="https://dataspace-connector.de/dsc_logo.svg" alt="Dataspace Connector Logo" width="200"></a>
  <br>
      Dataspace Connector - Full Setup
  <br>
</h1>

This is a deployment example for the **Full Setup** of the Dataspace Connector. It allows the exploration of all holistic functionalities of the Dataspace Connector and its services. 

---

**Note**: 
This example can not be used with the current IDS Metadata Broker off-the-shelf as a valid IDS identity certificate is not included. 
To get and install your own IDS identity certificate, please read the provided [Download DSC v4 Wiki](https://international-data-spaces-association.github.io/DataspaceConnector/assets/files/dsc_v4_wiki.zip).
Other than described there, in this example, the `config.json` and the `KeyStore` are located at  `/dataspaceconnector/config/`.

---

In this setup, the [Dataspace Connector](https://github.com/International-Data-Spaces-Association/DataspaceConnector) is started with the listed extensions:
* [Configuration Manager](https://github.com/International-Data-Spaces-Association/IDS-ConfigurationManager), 
* [Configuration Manager GUI](https://github.com/International-Data-Spaces-Association/IDS-ConfigurationManager-UI), 
* [DSC Camel Instance](https://github.com/International-Data-Spaces-Association/DSC-Camel-Instance),
* PostgreSQL DB

### Components & Versions
This deployment example builds on the following compatible versions:

| Component | Version |
|:----------|:--------|
| Dataspace Connector | 4.3.1 |
| Configuration Manager | 7.1.0 |
| Configuration Manager GUI | 7.1.0 |
| DSC Camel Instance | 1.2.1 |
| PostgreSQL | 12 |

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
    cd IDS-Deployment-Examples/dataspace-connector/full
    ```
3. Use a Docker Compose command to load the different Docker images of the components.
    ```
    docker-compose pull
    ```
4. Use a Docker Compose command to start all of the component's Docker containers.
   ```
   docker-compose up
   ```    
5. After all systems have been booted, they can be reached (by default) at the following URLs:
   - Dataspace Connector Swagger UI: https://localhost:8080/api/docs
   - Configuration Manager Swagger UI: http://localhost:8081/swagger-ui/index.html?url=/v3/api-docs/
   - Configuration Manager GUI: http://localhost:8082/dashboard
   - DSC Camel Instance: https://localhost:9090

Individual settings can be provided via the `.env-files` of the respective components and via the `config.json` in `/dataspaceconnector/config/` ([Download DSC v4 Wiki](https://international-data-spaces-association.github.io/DataspaceConnector/assets/files/dsc_v4_wiki.zip) for detailed information).

### Stop & Uninstall
  - Run `docker-compose down` inside the same folder you started the Dataspace Connector
  - Remove the repository folder

### Keycloak Configuration
Keycloak can be used as the Identity and Access Management System. Once the keycloak service is up and running, 
the following steps are necessary for configuration:

1. Log in to the Keycloak administration control. The admin credentials are found in keycloak/keycloak.env file. To access keycloak, navigate to localhost:8180 on the machine that is running the service
2. Create a realm named CMRealm (this can be configured in the configmanager/configmanager.env file)
3. Create a client named configmanager. Set the valid redirect URLs to ``http://localhost:8081/*`` (the configmanager URL)
4. In this step, you can create up to 3 roles. The role names have to be specified in configmanager/configmanager.env and should correspond to the IDS roles admin, consumer and provider
5. Create users and assign them roles
## Developers

This is an ongoing project of the developers of the Dataspace Connector repositories:
* [Dataspace Connector](https://github.com/International-Data-Spaces-Association/DataspaceConnector)
* [DSC Camel Instance](https://github.com/International-Data-Spaces-Association/DSC-Camel-Instance)
* [IDS Configuration Manager](https://github.com/International-Data-Spaces-Association/IDS-ConfigurationManager)
* [IDS Configuration Manager GUI](https://github.com/International-Data-Spaces-Association/IDS-ConfigurationManager-UI)





