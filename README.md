# Deploy Meilisearch on Azure Container Apps
Infrastructure as code for deploying [Meilisearch](https://www.meilisearch.com/) on Azure Container Apps and host DB files on Azure Storage Files

## Deploy using 'Deploy to Azure Button'
You can deploy Meilisearch to Azure Container Apps using the button below. Configuration is flexible, yet you can update the bicep file if you need to change configuration which is not exposed as parameters.

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Ftjoudeh%2FContainer-Apps-Meilisearch%2F46993fb85fa54df3c59c1c4fca6b8d4db5ea9268%2Fdeploy%2Fmain.json)

As per the image below, you can provide the below configuration:
- Region (Region for the resource group created).
- Location (Region for resources under the resource group, please use the same value as the **Region**).
- Application Name (Container App Name, used to set resource group name, storage, container app environment, and log analytics workspace).
- Container Resources (Container App CPU and Memory. Read [here](https://learn.microsoft.com/en-us/azure/container-apps/containers#configuration) to understand more about those CPU/Memory combinations).
- Deployment Environment (Used to identify deployment environment).
- Master Key (Master key stored in container app environment variable to protect your Meilisearch. 32 characters or more).

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







