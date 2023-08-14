// Parameters needed
param location string
@secure()
param sqlAdminPassword string

// SQL Server resource
resource sqlServer 'Microsoft.Sql/servers@2019-06-01-preview' = {
  name: 'sql-kc-prod-001'
  location: location
  properties: {
    administratorLogin: 'sql-kc-prod-001-admin'
    administratorLoginPassword: sqlAdminPassword
  }
}

resource sqlServerFirewallRule 'Microsoft.Sql/servers/firewallRules@2020-08-01-preview' = {
  parent: sqlServer
  name: 'sql-kc-prod-001-firewall-rule'
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '0.0.0.0'
  }
}

// SQL Database resource associated with the SQL Server
resource sqlDb 'Microsoft.Sql/servers/databases@2020-08-01-preview' = {
  parent: sqlServer
  name: 'db-kc-prod-001'
  location: location
}

// Commenting this section out since it appears to be an invalid resource type.
// You can replace or update it as necessary.
/*
resource sqlRoleAssignment 'Microsoft.Sql/servers/databases/roleAssignments@2021-02-01-preview' = {
  parent: sqlDb
  name: guid(functionApp.id, 'DataReaderRole', 'DataWriterRole')
  properties: {
    principalId: functionAppIdentity.identity.principalId
    roleId: resourceId('Microsoft.Sql/roleDefinitions', 'ID_FOR_DATAREADER_AND_DATAWRITER')
  }
}

// Azure Function App resource
resource functionApp 'Microsoft.Web/sites@2018-11-01' = {
  name: 'func-kc-prod-001'
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    // Configuration details for the function app can be added here.
  }
}

*/
