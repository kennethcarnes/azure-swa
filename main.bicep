// main.bicep

param location string
param SWAName string
param sku string
param skucode string
param repositoryUrl string
param branch string
param repositoryToken string
param appLocation string = 'app' // default to app unless you have a different directory
param apiLocation string = 'api' // default to api unless you have a different directory
param appArtifactLocation string = 'dist' // default to dist or where your build outputs to
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
