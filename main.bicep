// CodeAlpha DevOps - Tâche 1 : CI/CD Pipeline using Azure
// Provisionne : Azure Container Registry + App Service Plan (Linux) + Web App for Containers
//
// Déploiement :
//   az deployment group create \
//     --resource-group rg-codealpha-devops \
//     --template-file infra/main.bicep \
//     --parameters appName=codealpha-webapp acrName=codealphaacr<suffixe-unique>

@description('Nom de base utilisé pour les ressources (App Service)')
param appName string = 'codealpha-webapp'

@description('Nom du registre ACR (doit être globalement unique, alphanumerique uniquement)')
param acrName string

@description('Région Azure de déploiement')
param location string = resourceGroup().location

@description('SKU de l\'App Service Plan (B1 = Basic, suffisant pour un stage/démo)')
param appServicePlanSku string = 'B1'

@description('SKU du registre ACR (Basic suffit pour un usage de démonstration)')
param acrSku string = 'Basic'

resource acr 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: acrName
  location: location
  sku: {
    name: acrSku
  }
  properties: {
    adminUserEnabled: true // simplifie l'authentification du pipeline pour un projet de stage
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: '${appName}-plan'
  location: location
  kind: 'linux'
  sku: {
    name: appServicePlanSku
  }
  properties: {
    reserved: true // requis pour Linux
  }
}

resource webApp 'Microsoft.Web/sites@2023-12-01' = {
  name: appName
  location: location
  kind: 'app,linux,container'
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: 'DOCKER|${acr.properties.loginServer}/codealpha-webserver:latest'
      appSettings: [
        {
          name: 'DOCKER_REGISTRY_SERVER_URL'
          value: 'https://${acr.properties.loginServer}'
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_USERNAME'
          value: acr.listCredentials().username
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_PASSWORD'
          value: acr.listCredentials().passwords[0].value
        }
        {
          name: 'WEBSITES_PORT'
          value: '80'
        }
        {
          name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
          value: 'false'
        }
      ]
      healthCheckPath: '/health'
    }
    httpsOnly: true
  }
}

// Diagnostics — logs applicatifs envoyés vers App Service Logs (consultable depuis le portail / az monitor)
resource webAppDiagnostics 'Microsoft.Web/sites/config@2023-12-01' = {
  parent: webApp
  name: 'logs'
  properties: {
    applicationLogs: {
      fileSystem: {
        level: 'Information'
      }
    }
    httpLogs: {
      fileSystem: {
        retentionInMb: 35
        enabled: true
      }
    }
  }
}

output acrLoginServer string = acr.properties.loginServer
output webAppUrl string = 'https://${webApp.properties.defaultHostName}'
output webAppName string = webApp.name
