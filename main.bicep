// main.bicep

param location string
param SWAName string
param sku string
param skucode string
param repositoryUrl string
param branch string
param repositoryToken string
param appLocation string
param apiLocation string
param appArtifactLocation string
param tenantId string
param endpointName string
param profileName string
@secure()
param sqlAdminPassword string

module backend './backend.bicep' = {
  name: 'backendDeployment'
  params: {
    location: location
    sqlAdminPassword: sqlAdminPassword
  }
}

module frontend './frontend.bicep' = {
  name: 'frontendDeployment'
  params: {
    SWAName: SWAName
    location: location
    sku: sku
    skucode: skucode
    repositoryUrl: repositoryUrl
    branch: branch
    repositoryToken: repositoryToken
    appLocation: appLocation
    apiLocation: apiLocation
    appArtifactLocation: appArtifactLocation
    endpointName: endpointName
    profileName: profileName
  }
}

module monitoringSecurity './monitoring-security.bicep' = {
  name: 'monitoringSecurityDeployment'
  params: {
    location: location
    tenantId: tenantId
  }
}
