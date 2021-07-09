﻿<h1 align="center">
Metadata-broker-open-core
</h1>
This is an implementation of an International Data Spaces (IDS) Metadata Broker, which is a registry for IDS Connector self-description documents. It is currently under development and intends to act as a reference for members of the International Data Spaces Association (IDSA) to help with the implementation of custom Broker solutions. Work on this repository closely aligns with the IDS Handshake Document, which describes the concepts of communication on the IDS in textual form.

This document aims to aid IT administrators or developers in the installation of the IDS Metadata Broker.  

---  
**Note**: this guide works with provided images and is not targeted for development purposes. Thus, instructions for building and editing the docker image file will not be included here. Metadata Broker is still actively maintained by Fraunhofer IAIS. In case of errors, please send an email to contact@ids.fraunhofer.de.

---


### 1 Prerequisites

In this section, we will provide some guidance as to recommendations for the number of resources that should be available to smoothly operate the IDS Metadata Broker. The actual number of resources required heavily depends on the load. In case of very little traffic, fewer resources than listed below might be required.


#### 1.1 Hardware

2GB of disk space is required for operating the IDS Metadata Broker, though we recommend providing at least 20GB of free disk storage to avoid running out of disk space with increasing number of registered items.

To provide enough processing power for all Docker containers, we recommend using a 64bit quad core processor or better.

#### 1.2 Software

- **OS**: We recommend using a Linux based operating system. However, any operating system with a Docker installation can be used (tested on Ubuntu 20.04 and Windows 10). More strict hardware requirements than listed above might apply if a non-Linux operating system is used.
- **Git**
- **Docker**
- **Docker compose**
- **OpenSSL**: A valid X.509 certificate, signed by a trusted certification authority, is strongly recommended to avoid warnings about insecure HTTPS connections. Docker must be installed on the target machine. For the SSL certificate you need to have these two files:
--   **server.crt:** an x509 certificate, either self-signed or from an official CA
--   **server.key:** the private key for the certificate
    The certificate needs to be of .crt format and must have the name server.crt and the file for private key should have the name server.key. In case your certificate is of .pem format, it can be converted with the following commands, which require OpenSSL to be installed:

			openssl x509 -in mycert.pem -out server.crt
			openssl rsa -in mykey.pem -out server.key
			mkdir cert
			mv server.crt cert/
			mv server.key cert/

### 2 Installation Steps
#### 2.1 Cloning the repository
	git clone https://github.com/International-Data-Spaces-Association/metadata-broker-open-core.git
#### 2.2 Configuring the Docker-Compose File

Once the repository is cloned, the docker-compose file will be found in this path:

	<metadata-broker-open-coredocker/composefiles/Meta-Data-Broker/broker-localhost/docker-compose.yml >

  


The most crucial part of adapting the configuration is to provide the correct location of the X.509 certificate created in **Section 1.2** in the broker-reverseproxy service. 

**For Linux users:**  if the location of the certificate is *“/home/ids/cert”*, the corresponding configuration in the yml file is:
		
	services: broker-reverseproxy:
		image: registry.gitlab.cc-asp.fraunhofer.de:4567/eis-ids/broker/reverseproxy
		volumes:
		- /home/ids/cert:/etc/cert/
		[…]



**For Windows users:**  if the location of the certificate is *“c:/etc/ids/cert”*, the corresponding configuration in the yml file is:  


	services: broker-reverseproxy:
		image: registry.gitlab.cc-asp.fraunhofer.de:4567/eis-ids/broker/reverseproxy
		volumes:
		- c:/etc/ids/cert:/etc/cert/
		[…]

#### 2.3 Downloading the Docker Images

All the IDS Metadata Broker Docker images are hosted at the GitLab of Fraunhofer IAIS. No credentials needed to download the images. The following command is for pulling all docker images:

		docker-compose pull

Note that this command should be executed in the same path of docker-compose.yml file.
  

#### 2.4 Starting up the IDS Metadata Broker

To start up the IDS Metadata Broker, run the following command inside the directory of the docker-compose.yml file:

		docker-compose up –d

  

This process can take several minutes to complete. You can test whether the IDS Metadata Broker has successfully started by opening [https://localhost](https://localhost/). The result should be a JSON document, providing some general metadata about the IDS Metadata Broker. 

Furthermore, the docker-compose logs command can be used to access the logs for a docker-compose.yml file, see [here](https://docs.docker.com/compose/reference/logs/).

  

#### 2.5 Interacting with the IDS Metadata Broker


The IDS Metadata Broker accepts and sends messages according to the IDS information model. This model uses the Resource Description Framework (RDF) to leverage the power of linked data. Many examples about representations of IDS concepts can be found at [https://github.com/International-Data-Spaces-Association/InformationModel/tree/develop/examples](https://github.com/International-Data-Spaces-Association/InformationModel/tree/develop/examples).

The multipart endpoint of IDS Metadata Broker is “/infrastructure”. If the IDS Metadata Broker is running using docker-compose as mentioned earlier, an HTTP POST request can be sent to interact with it. We provide some example messages, illustrating all core functions of the IDS Metadata Broker in this  [postman collection](https://www.getpostman.com/collections/1cecd0def2941a993e80).

In addition to the multipart endpoint, the IDS Metadata Broker also serves a prototypical [IDS-REST](https://www.getpostman.com/collections/01d6bf596f67303c08ce) endpoint at “/catalog”. This endpoint will reach a non-prototype state soon after the final specification of the IDS-REST protocol.
  

### 3 Updating and Stopping the IDS Metadata Broker 
#### 3.1 Updating the IDS Metadata Broker 
To update an existing installation of the IDS Metadata Broker, first repeat the steps explained in section “Downloading the Docker Images”. Containers can be either hot updated or restarted to apply the changes. To hot update a container, run the following command:

		docker-compose up -d --no-deps --build <container name>

Alternatively, one can restart the entire service by running:

		docker-compose down
		docker-compose up –d

#### 3.2 Stopping the IDS Metadata Broker 
To stop the Broker run the following in the terminal in the same path as the docker-compose.yml file:
			
		docker-compose down

## Developers
This is an ongoing project of the developers of the IDSA Repositories:
* [DataspaceConnector](https://github.com/International-Data-Spaces-Association/DataspaceConnector)
* [DSC-Camel-Instance](https://github.com/International-Data-Spaces-Association/DSC-Camel-Instance)
* [IDS-ConfigurationManager](https://github.com/International-Data-Spaces-Association/IDS-ConfigurationManager)
* [IDS-ConfigurationManager-UI](https://github.com/International-Data-Spaces-Association/IDS-ConfigurationManager-UI)
* [IDS-Messaging-Services](https://github.com/International-Data-Spaces-Association/IDS-Messaging-Services)
* [IDS-Metadata-Broker-Open-Core](https://github.com/International-Data-Spaces-Association/metadata-broker-open-core)
