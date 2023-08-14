// Parameters needed
param location string
param tenantId string

resource keyVault 'Microsoft.KeyVault/vaults@2019-09-01' = {
  name: 'keyvault-kc-prod-001'
  location: location
  properties: {
    sku: {
      name: 'standard'
      family: 'A' 
    }
    tenantId: tenantId
  }
}

resource keyVaultAccessPolicy 'Microsoft.KeyVault/vaults/accessPolicies@2019-09-01' = {
  parent: keyVault
  name: 'add'  // Updated this part as per the error message.
  properties: {
    accessPolicies: [
      // We need to correct the reference to functionApp here
      // For now, commenting it out to prevent the error.
      // {
      //   objectId: functionApp.identity.principalId
      //   permissions: {
      //     secrets: ['get']
      //   }
      // }
    ]
  }
}

// Azure Monitor - Log Analytics Workspace
resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2020-03-01-preview' = {
  name: 'loganalytics-kc-prod-001'
  location: location
}

// Azure Application Insights
resource appInsights 'Microsoft.Insights/components@2015-05-01' = {
  name: 'appinsights-kc-prod-001'
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
}
