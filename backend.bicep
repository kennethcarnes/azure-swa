// backend.bicep

// Parameters needed
param location string
@secure()
param sqlAdminPassword string


// SQL Server resource
resource sqlServer 'Microsoft.Sql/servers@2019-06-01-preview' = {
  name: 'sql-kc-prod-001'
  location: location
  properties: {
    administratorLogin: 'admin'
    administratorLoginPassword: sqlAdminPassword
  }
}

// SQL Database resource associated with the SQL Server
resource sqlDb 'Microsoft.Sql/servers/databases@2019-06-01-preview' = {
  parent: sqlServer
  name: 'db-kc-prod-001'
  location: location
}

// Azure Function App resource
resource functionApp 'Microsoft.Web/sites@2018-11-01' = {
  name: 'func-kc-prod-001'
  location: location
  properties: {
    // Configuration details for the function app can be added here.
  }
}
