@description('The name of Azure Container Apps Environment')
param acaEnvironmentName string

@description('The Azure region where all resources in this example should be created')
param location string = resourceGroup().location

@description('A list of tags to apply to the resources')
param resourceTags object

param logAnalyticsWorkspaceCustomerId string

@secure()
param logAnalyticsWorkspacePrimarySharedKey string 

resource environment 'Microsoft.App/managedEnvironments@2022-03-01' = {
  name: acaEnvironmentName
  location: location
  tags: resourceTags
  properties: {
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: logAnalyticsWorkspaceCustomerId
        sharedKey: logAnalyticsWorkspacePrimarySharedKey
      }
    }
  }
}

output acaEnvironmentId string = environment.id
