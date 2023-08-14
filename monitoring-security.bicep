// monitoring-security.bicep

// Parameters needed
param location string
param tenantId string

resource keyVault 'Microsoft.KeyVault/vaults@2019-09-01' = {
  name: 'keyvault-kc-prod-001'
  location: location
  properties: {
    sku: { name: 'standard' , family: 'A' } 
    tenantId: tenantId
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
