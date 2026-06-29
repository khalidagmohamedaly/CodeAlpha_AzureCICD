# ☁️ CodeAlpha Azure CI/CD Pipeline

![Azure](https://img.shields.io/badge/Azure-DevOps-0078D4?style=for-the-badge&logo=azuredevops&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Node.js](https://img.shields.io/badge/Node.js-339933?style=for-the-badge&logo=nodedotjs&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

## Overview

This repository contains my solution for **Task 1 -- Azure CI/CD
Pipeline** completed during the **CodeAlpha DevOps Internship**.

The project demonstrates a complete CI/CD workflow using Azure DevOps to
build, test, containerize and deploy a Node.js application with Docker
and Azure services.

## Objectives

-   Automate application builds
-   Implement Continuous Integration
-   Implement Continuous Deployment
-   Build Docker images
-   Push images to Azure Container Registry
-   Deploy to Azure App Service
-   Learn Infrastructure as Code using Bicep

## Technologies

-   Azure DevOps
-   Azure Pipelines
-   Azure Container Registry
-   Azure App Service
-   Docker
-   Node.js
-   Git & GitHub
-   Bicep

## Project Structure

``` text
.
├── azure-pipelines.yml
├── Dockerfile
├── package.json
├── server.js
├── infra/
│   └── main.bicep
└── README.md
```

## CI/CD Workflow

``` mermaid
flowchart LR
A[GitHub Push] --> B[Azure Pipelines]
B --> C[Build]
C --> D[Test]
D --> E[Docker Build]
E --> F[Azure Container Registry]
F --> G[Azure App Service]
```

## Prerequisites

-   Azure Subscription
-   Azure DevOps Project
-   Azure CLI
-   Docker Desktop
-   Git
-   Node.js

## Installation

``` bash
git clone https://github.com/YOUR_USERNAME/CodeAlpha_AzureCICD.git
cd CodeAlpha_AzureCICD
npm install
npm start
```

## Build Docker Image

``` bash
docker build -t azure-cicd .
docker run -p 3000:3000 azure-cicd
```

## Azure Pipeline Stages

1.  Checkout source
2.  Install dependencies
3.  Run tests
4.  Build Docker image
5.  Push image to ACR
6.  Deploy to Azure App Service

## Infrastructure as Code

The `infra/main.bicep` template provisions Azure resources consistently
and reproducibly.

## Security

-   Store secrets in Azure DevOps Library or Key Vault.
-   Never commit credentials.
-   Use service connections for deployments.

## Future Improvements

-   Kubernetes deployment
-   Helm charts
-   SonarQube quality gates
-   Terraform support
-   Monitoring with Azure Monitor

## Learning Outcomes

-   CI/CD concepts
-   Cloud deployment
-   Docker containerization
-   Azure services
-   DevOps automation
-   Infrastructure as Code

## Author

**Khalid Ag Mohamed Aly**

DevOps Intern --- CodeAlpha

LinkedIn: https://linkedin.com/in/YOURPROFILE

GitHub: https://github.com/YOUR_USERNAME

## License

MIT License

------------------------------------------------------------------------

*Developed as part of the CodeAlpha DevOps Internship.*
