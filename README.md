# Deploy Meilisearch on Azure Container Apps
Infrastructure as code for deploying [Meilisearch](https://www.meilisearch.com/) on Azure Container Apps and host DB files on Azure Storage Files

##Deploy using Deploy to Azure Button
You can deploy Meilisearch to Azure Container Apps using the button below. Configuration is flexible yet you can update the bicep file if you need to change configuration which is not exposed as parameters

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fgithub.com%2Ftjoudeh%2FContainer-Apps-Meilisearch%2Fblob%2F46993fb85fa54df3c59c1c4fca6b8d4db5ea9268%2Fdeploy%2Fmain.json)

## Deploy using Azure CLI
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







