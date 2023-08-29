# Overview
This project uses GitHub Actions, Bicep, and Azure CLI to deploy a static web app and dynamic assets stored in blob storage.

[![Build and Deploy to Azure](https://github.com/kennethcarnes/azure-swa/actions/workflows/build-and-deploy-to-azure.yml/badge.svg)](https://github.com/kennethcarnes/azure-swa/actions/workflows/build-and-deploy-to-azure.yml)

## DevOps Practices
### Infrastructure as Code (IaC)
Infrastructure for the project is managed using Azure Bicep files located under the `infra` directory.

```bicep
// Example from backend.bicep
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: storageAccountName
  location: location
  ...
}
```
### Continuous Integration/Continuous Deployment (CI/CD)
CI/CD is managed using GitHub Actions. The workflow is defined in the `.github/workflows/build-and-deploy-to-azure.yml` file.

```yaml
name: Build and Deploy to Azure

on:
  push:
    branches:
      - main
      ...
```
### Version Control
Git is used for version control with meaningful commit messages.
## File Structure
```
├── .github
│ └── workflows
│ └── build-and-deploy-to-azure.yml
├── assets
│ ├── Kenneth-Carnes-Resume.pdf
│ └── Photo.jpg
├── infra
│ ├── backend.bicep
│ ├── frontend.bicep
│ └── main.bicep
├── scripts
│ └── update-placeholders.py
└── src
├── index.html
└── css
└── styles.css
```
## Azure Role-Based Access Control (RBAC) Setup
This guide walks you through the process of setting up Azure RBAC using Azure CLI commands.

### Prerequisites
Make sure you have Azure CLI installed and you're logged in to your Azure account.

### 1. Create an Azure Active Directory Application

```
az ad app create --display-name "display-name"
```

### 2. Create a service principal for the Azure AD application.
Replace `<App ID>` with the ID of the Azure AD application you created in Step 1.

```bash
az ad sp create --id "<App ID>"
```

### 3. Create a Resource Group
```bash
az group create --name "rg-name-prod-001" --location "eastus2"
```

### 4. Assign Roles
Replace `<Subscription ID>` and `<Object ID>` with your Azure Subscription ID and the Object ID of the service principal you created in Step 2. Assign `contributor` role to the service principal for a specific resource group
```bash
az role assignment create --role "contributor" --subscription "<Subscription ID>" --assignee-object-id "<Object ID>" --assignee-principal-type "ServicePrincipal" --scope "/subscriptions/<Subscription ID>/resourceGroups/rg-name-prod-001"
```
### 5. Create Service Principal for RBAC.
Replace `<App ID>` and `<Subscription ID>` with your Azure Application ID and Subscription ID, respectively. Create a service principal and assign it `contributor` role within the scope of the specific resource group.
```bash
az ad sp create-for-rbac --name "kc-app-github-azure-swa" --role "contributor" --scopes "/subscriptions/<Subscription ID>/resourceGroups/rg-name-prod-001" --sdk-auth
```