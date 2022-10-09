
@description('The name of Azure Container Apps Environment')
param acaEnvironmentName string

@description('The name of your storage account')
param storageAccountResName string

@description('The storage account key')
@secure()
param storageAccountResourceKey string 

@description('The ACA env storage name mount')
param storageNameMount string

@description('The name of the Azure file share. Defaults to applicationName value.')
param shareName string

resource environment 'Microsoft.App/managedEnvironments@2022-03-01' existing = {
  name: acaEnvironmentName
}

//Environment Storages
resource permanentStorageMount 'Microsoft.App/managedEnvironments/storages@2022-03-01' = {
  name: storageNameMount
  parent: environment
  properties: {
    azureFile: {
      accountName: storageAccountResName
      accountKey: storageAccountResourceKey
      shareName: shareName
      accessMode: 'ReadWrite'
    }
  }
}
