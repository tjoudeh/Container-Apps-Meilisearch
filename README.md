# Deploy Meilisearch on Azure Container Apps
Companion [blog post](https://bit.ly/3TavzGb) to go over the creation of this Infrastructure as Code for deploying [Meilisearch](https://www.meilisearch.com/) on Azure Container Apps and host DB files on Azure Storage Files.

## Deploy using 'Deploy to Azure Button'
You can deploy Meilisearch to Azure Container Apps using the button below. Configuration is flexible, yet you can update the bicep file if you need to change configuration which is not exposed as parameters.

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Ftjoudeh%2FContainer-Apps-Meilisearch%2Fmaster%2Fdeploy%2Fmain.json)

As per the image below, you can provide the below configuration:

- Region (Region for the resource group created).
- Location: The Azure region code ("westus", "northeurope", "australiacentral", etc...). This should be a region where Azure container Apps and Azure Storage is available, you can check where Azure Container Apps are available on this [link.](https://azure.microsoft.com/en-us/explore/global-infrastructure/products-by-region/?products=storage,container-apps&regions=all). please use the same value as the **Region**
- Application Name: the name of the Meilisearch search service, this name will be part of the FQDN and will be used to set resource group name, storage, container app environment, and log analytics workspace.
- Container Resources: Container App CPU and Memory. Read [here](https://learn.microsoft.com/en-us/azure/container-apps/containers#configuration) to understand more about those CPU/Memory combinations. The limits are soft limits and you can request to increase the quota by submitting a [support request.](https://azure.microsoft.com/support/create-ticket/)
- Deployment Environment: Used to identify deployment resources ("dev", "stg", "prod", etc...) and tag them with the selected environment, this has nothing to do with the capacity or performance of the resources provisioned. This will be useful if you are deploying multiple  Meilisearch instances under the same subscription for dev/test scenarios.
- Meilisearch Master Key: This is the Master API Key used with the Meilisearch instance, minimum length is 32 characters. The recommendation is to generate a strong key, if not provided deployment template will generate a guide as the Master API key.

![image](https://user-images.githubusercontent.com/3114431/194722145-090b113e-9a6d-4f50-ae07-c87ab8298009.png)

When the deployment completes successfully, you should see the resource group and the below resources created under the subscription selected as the image below:

![image](https://user-images.githubusercontent.com/3114431/194722158-842e86b6-f675-45b3-aeee-1d1b9c4a40b1.png)

## Deploy using 'Azure CLI'
1. Ensure you have logged in to Azure CLI and you selected the right subscription.
2. If you are using PowerShell you can execute the command below, do not forget to generate your own Master Key

```PowerShell
az deployment sub create `
  --template-file ./main.bicep `
  --location WestUS `
  --parameters '{ \"meilisearchMasterKey\": {\"value\":\"YOUR_MASTER_KEY\"}, \"applicationName\": {\"value\":\"YOUR_APP_NAME\"}, \"deploymentEnvironment\": {\"value\":\"dev\"}, \"location\": {\"value\":\"westus\"} }'
```

3. If you are using Bash you can execute the command below:
```bash
az deployment sub create \
--name YOUR_APP_NAME \
--template-file .\main.bicep 
--location WestUS \
--parameters applicationName=MYAPPLICATIONNAME meilisearchMasterKey=YOUR_MASTER_KEY deploymentEnvironment=dev location=westus
```







