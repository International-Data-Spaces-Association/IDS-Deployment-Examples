<h1 align="center">
  <br>
  <a href="https://dataspace-connector.de/dsc_logo.svg"><img src="https://dataspace-connector.de/dsc_logo.svg" alt="Dataspace Connector Logo" width="200"></a>
  <br>
      Dataspace Connector - Slim Setup
  <br>
</h1>

This is the **Slim Setup** of the Dataspace Connector.
In this setup only the [Dataspace Connector](https://github.com/International-Data-Spaces-Association/DataspaceConnector) and PostgreSQL as database are started, without Camel, ConfigurationManager and UI.

This allows us to only using the core functionalities of the Dataspace Connector without having an graphical user interface and the logic of the ConfigurationManager to install IDS Apps and configure Camel routes.

## Deployment Example
This Dataspace Connector Deployment example consists of the following components:
- PostgreSQL 13
- Dataspace Connector latest

---

**Note**: 
This example can not be used with the current IDS Metadata Broker off-the-shelf, because a valid IDS identity certificate is not included. 

---
### Prerequisites
  - Git
  - Minikube
  - Helm

### Install Steps
  - Clone the Dataspace Connector repo 
    ```
    git clone https://github.com/International-Data-Spaces-Association/DataspaceConnector.git
    ```
  - Open a new terminal inside the cloned repo
    ```
    cd DataspaceConnector
    ```
  - Install in your cluster via helm
    ```
    helm install dataspaceconnector charts/dataspace-connector
    ```
  - Follow the instructions for connecting to the service displayed in the terminal e.g.:
    ```
    1. Get the application URL by running these commands:
    export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=dataspace-connector,app.kubernetes.io/instance=dataspaceconnector" -o jsonpath="{.items[0].metadata.name}")
    export CONTAINER_PORT=$(kubectl get pod --namespace default $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
    echo "Visit http://127.0.0.1:8080 to use your application"
    kubectl --namespace default port-forward $POD_NAME 8080:$CONTAINER_PORT
    ```
  - Login with username `admin` and password `password`
  - The [Communication Guide](https://international-data-spaces-association.github.io/DataspaceConnector/CommunicationGuide) explains how to use the APIs of the connector

Individual settings can be made by modifying the chart itself.

### Uninstall
  - Run `helm uninstall dataspaceconnector`
  - Remove the repository folder
  
## Developers

This is an ongoing project of the developers of the Dataspace Connector Repository:
* [DataspaceConnector](https://github.com/International-Data-Spaces-Association/DataspaceConnector)