# Azure Bicep with GitHub Actions CI/CD Workflow

Personal project to demonstrate a multi-environment deployment strategy using Azure Bicep and GitHub Actions. 

## Directory Structure

```powershell
.
├── .github
│   └── workflows
│       └── build-and-deploy-to-azure.yml
└── infra
    ├── main.bicep
    ├── frontend.bicep
    ├── backend.bicep
    └── ... (other infrastructure files)
```

## Setting Up GitHub Secrets

For each environment (e.g., dev, test, prod), set up corresponding secrets:

- `DEV_SWA_NAME`, `TEST_SWA_NAME`, `PROD_SWA_NAME`
- `DEV_AZURE_RESOURCE_GROUP`, `STAGING_AZURE_RESOURCE_GROUP`, etc.
- `AZURE_CREDENTIALS` (common across environments or specific to each)

## IaC
### Bicep Files
- **main.bicep**: As central orchestrator, this file will invoke other bicep modules as needed.
- **frontend.bicep, backend.bicep, ect.**: Resource-specific templates.

### Parameters
- **Use Generic Paramaters** instead of hardcoding values in your .bicep files.
  ```yaml
  param swaName string
  param location string
  param swaSku string
  // ... other parameters
  ```

## GitHub Actions Workflow
### Environments feature
- Define environments in GitHub Actions such as dev, staging, and prod.
- Assign environment-specific secrets to each environment in GitHub.
- GitHub Actions will decide which secrets to use based on the triggering branch or event.
### Workflow structure
- Trigger the workflow on push or PR events.
- Have a job for building the Bicep file.
- Have another job with branching logic for each environment. Use conditions to determine which environment to deploy to based on branches or other conditions.
  ```yaml
  name: Build and Deploy to Azure

  on:
    push:
      branches:
        - main
        - develop
        # ... other branches or conditions

  jobs:
    # ... (Building and other jobs)

    deploy:
      needs: [otherJobNames]
      runs-on: ubuntu-latest
      steps:
        - name: Checkout
          uses: actions/checkout@v2

        - name: Set environment
          run: |
            if [[ "${{ github.ref }}" == "refs/heads/main" ]]; then
              echo "SWA_NAME=${{ secrets.PROD_SWA_NAME }}" >> $GITHUB_ENV
              # ... set other prod variables
            elif [[ "${{ github.ref }}" == "refs/heads/develop" ]]; then
              echo "SWA_NAME=${{ secrets.DEV_SWA_NAME }}" >> $GITHUB_ENV
              # ... set other dev variables
            fi

        # ... (Rest of the deployment steps)

## Workflow Example
### 1. Developer pushes to the develop branch:
- GitHub Actions workflow triggers.
- GitHub Actions sees it's the `develop` branch and chooses the `DEV_*` secrets.
- Bicep files are built.
- Deployment starts, with main.bicep getting the values like:
  - `swaName` from `DEV_SWA_NAME` secret.
- `main.bicep` then passes this `swaName` value to the other Bicep files it orchestrates, like `frontend.bicep`.
### 2. Developer pushes to the main branch:
- Workflow is similar, but this time `PROD_*`` secrets are used.
- Deployment will be to the production environment using production-specific configurations.

## Considerations
- The IaC remains clean and doesn't have any branching logic or environment-specific details.
- Environment management and CI/CD complexities are handled in the GitHub Actions workflow.
- Secrets and configurations for each environment are stored and managed in GitHub Secrets.

This provides clear separation in terms of where configurations for each environment reside, and flexibility to adapt the CI/CD process as needed without touching the IaC.

### Advantages
- **Compact:** Less redundant code if deployment steps are largely identical across environments.
- **Unified Workflow:** A single job handles deployment, which might be easier to monitor and manage if you want all deployments to follow the exact same pattern.

### Disadvantages
- **Complexity:** As you add more environments, the branching logic can become lengthy and more challenging to manage.
- **Less Flexible:** If a specific environment requires a unique deployment step, integrating it can become more convoluted.