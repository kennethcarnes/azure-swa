param location string

// Azure SQL Database
resource sqlServer 'Microsoft.Sql/servers@2019-06-01-preview' = {
  name: 'mySqlServer'
  location: location
  properties: {
    administratorLogin: 'admin'
    administratorLoginPassword: 'password' // Ideally, should be stored in Azure Key Vault
  }
}

resource sqlDb 'Microsoft.Sql/servers/databases@2019-06-01-preview' = {
  name: '${sqlServer.name}/myDb'
  location: location
}

// Azure Function for contact form processing
resource functionApp 'Microsoft.Web/sites@2018-11-01' = {
  name: 'myFunctionApp'
  location: location
  properties: {
    // Configuration details
  }
}
