
@description('The name of your Log Analytics Workspace')
param logAnalyticsWorkspaceName string

@description('The Azure region where all resources in this example should be created')
param location string = resourceGroup().location

@description('A list of tags to apply to the resources')
param resourceTags object

resource logAnalyticsWorkspace'Microsoft.OperationalInsights/workspaces@2021-12-01-preview' = {
  name: logAnalyticsWorkspaceName
  tags: resourceTags
  location: location
  properties: any({
    retentionInDays: 30
    features: {
      searchVersion: 1
    }
    sku: {
      name: 'PerGB2018'
    }
  })
}

var sharedKey = listKeys(logAnalyticsWorkspace.id, logAnalyticsWorkspace.apiVersion).primarySharedKey

output workspaceResourceId string = logAnalyticsWorkspace.id
output logAnalyticsWorkspaceCustomerId string = logAnalyticsWorkspace.properties.customerId
output logAnalyticsWorkspacePrimarySharedKey string = sharedKey
