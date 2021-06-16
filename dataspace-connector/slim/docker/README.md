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
- Postgres 12
- Dataspace Connector 4.1

### Prerequisites:
  - git
  - docker
  - docker-compose

TODO Add version numbers

### Install Steps:
  - Clone repo
  - Run 'docker-compose up' in this folder
  - Go to 'https://localhost:8080/admin/api' 
  - Login with username: 'admin' and password 'password'

Individual settings can be made via the .env-files of the respective components.

### Uninstall:
  - Run 'docker-compose down' in this folder
  - Remove the repository folder
  
## Developers

This is an ongoing project of the developers of the Dataspace Connector Repository:
* [DataspaceConnector](https://github.com/International-Data-Spaces-Association/DataspaceConnector)