param location string

// Azure Key Vault for secrets
resource keyVault 'Microsoft.KeyVault/vaults@2019-09-01' = {
  name: 'myKeyVault'
  location: location
  properties: {
    // Configuration details
  }
}

// Azure Monitor - Log Analytics Workspace
resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2020-03-01-preview' = {
  name: 'myLogAnalytics'
  location: location
  sku: {
    name: 'PerGB2018'
  }
}

// Azure Application Insights
resource appInsights 'Microsoft.Insights/components@2015-05-01' = {
  name: 'myAppInsights'
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
}
