param containerAppName string
param location string 
param environmentId string 
param containerImage string
param targetPort int
param containerRegistry string
param containerRegistryUsername string
param isPrivateRegistry bool
param registryPassName string
param minReplicas int = 0
param maxReplicas int = 1
@secure()
param secListObj object
param envList array = []
param revisionMode string = 'Single'
param storageNameMount string
param volumeName string
param mountPath string
param resourceTags object
param resourceAllocationCPU string
param resourceAllocationMemory string
//param containerResources object

resource containerApp 'Microsoft.App/containerApps@2022-06-01-preview' = {
  name: containerAppName
  location: location
  tags: resourceTags
  properties: {
    managedEnvironmentId: environmentId
    configuration: {
      activeRevisionsMode: revisionMode
      secrets: secListObj.secArray
      registries: isPrivateRegistry ? [
        {
          server: containerRegistry
          username: containerRegistryUsername
          passwordSecretRef: registryPassName
        }
      ] : null
      ingress: {
        external: true
        targetPort: targetPort
        transport: 'auto'
        traffic: [
          {
            latestRevision: true
            weight: 100
          }
        ]
      } 
      dapr: null
    }
    template: {
      containers: [
        {
          image: containerImage
          name: containerAppName
          env: envList
          volumeMounts: [
            { 
               mountPath:mountPath
               volumeName:volumeName
            }
          ]
          resources:{
            cpu: json(resourceAllocationCPU)
            memory: resourceAllocationMemory
           }
        }
      ]
      volumes: [
        {
           name: volumeName
           storageName: storageNameMount
           storageType: 'AzureFile'
        }
      ]
      scale: {
        minReplicas: minReplicas
        maxReplicas: maxReplicas
      }
    }
  }
}

output fqdn string =  containerApp.properties.configuration.ingress.fqdn
