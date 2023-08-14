// backend.bicep

// Parameters needed
param location string
@secure()
param sqlAdminPassword string


// SQL Server resource
resource sqlServer 'Microsoft.Sql/servers@2019-06-01-preview' = {
  name: 'kc-sqlserver'
  location: location
  properties: {
    administratorLogin: 'admin'
    administratorLoginPassword: sqlAdminPassword
  }
}

// SQL Database resource associated with the SQL Server
resource sqlDb 'Microsoft.Sql/servers/databases@2019-06-01-preview' = {
  parent: sqlServer
  name: 'kc-personaldb'
  location: location
}

// Azure Function App resource
resource functionApp 'Microsoft.Web/sites@2018-11-01' = {
  name: 'kc-funcapp'
  location: location
  properties: {
    // Configuration details for the function app can be added here.
  }
}
