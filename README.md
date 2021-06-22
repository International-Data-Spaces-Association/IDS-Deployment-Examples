<h1 align="center">
      IDS Deployment Examples
  <br>
</h1>


<p align="center">
  <a href="#Overview">Overview</a> •
  <a href="#contributing">Contribute</a> •
  <a href="#developers">Responsible</a> •
  <a href="https://github.com/International-Data-Spaces-Association/IDS-Deployment-Examples/issues">Issues</a>
</p>

The IDS Deployment Examples Repository is used to provide working deployments across the various IDSA repositories. This has several advantages:
* The examples provide appropriately pre-built Docker, Kubernetes, Helm configurations that others can use.
* It ensures that specific versions have been tested together and work together.
* In addition to the actual components from the [IDS Reference Architecture Model](https://www.internationaldataspaces.org/wp-content/uploads/2019/03/IDS-Reference-Architecture-Model-3.0.pdf), combinations of components can also be provided as a setup.

## Overview

The repository is organized as follows: 
* Per component or component bundle (union from e.g. Dataspace Connector and Metadata Broker or Dataspace Connector and Trusted Connector) a folder is created. This again contains possibly independent variations for e.g. minimal/full Setups or Helm/Kubernetes/Docker Setups.
* Additionally there is a templates folder, which provides templates for the Deployment Examples.


## Contributing

You are very welcome to contribute to this project when you find a bug, want to suggest an
deployment, or have an idea for a useful feature. Please find a set of guidelines at the
[CONTRIBUTING.md](CONTRIBUTING.md) and the [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md).

## Developers

This is an ongoing project of the developers of the IDSA Repositories:
* [DataspaceConnector](https://github.com/International-Data-Spaces-Association/DataspaceConnector)
* [DSC-Camel-Instance](https://github.com/International-Data-Spaces-Association/DSC-Camel-Instance)
* [IDS-ConfigurationManager](https://github.com/International-Data-Spaces-Association/IDS-ConfigurationManager)
* [IDS-ConfigurationManager-UI](https://github.com/International-Data-Spaces-Association/IDS-ConfigurationManager-UI)
* [IDS-Messaging-Services](https://github.com/International-Data-Spaces-Association/IDS-Messaging-Services)
* and anyone interested in providing deployment examples for open source IDS components.

## License

Copyright © 2021 International Data Spaces Association. This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) for details.