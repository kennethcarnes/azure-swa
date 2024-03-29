param deployFrontend bool = true
param deployBackend bool = true
param location string
param swaName string
param swaSku string
param repositoryUrl string
param branch string
param repositoryToken string
param storageAccountName string
param blobContainerName string
param appLocation string = 'src'
param apiLocation string = 'api'
param appArtifactLocation string = 'dist'

module frontend './frontend.bicep' = if (deployFrontend) {
name: 'frontendDeployment'
params: {
  swaName: swaName
  location: location
  swaSku: swaSku
  repositoryUrl: repositoryUrl
  branch: branch
  repositoryToken: repositoryToken
  appLocation: appLocation
  apiLocation: apiLocation
  appArtifactLocation: appArtifactLocation
}
}

module storage './backend.bicep' = if (deployBackend) {
  name: 'backendDeployment'
  params: {
    storageAccountName: storageAccountName
    blobContainerName: blobContainerName
    location: location
  }
}
