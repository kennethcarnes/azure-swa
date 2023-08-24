// frontend.bicep
param swaName string
param location string
param swaSku string
param repositoryUrl string
param branch string
@secure()
param repositoryToken string
param appLocation string = '/'
param apiLocation string = 'api'
param appArtifactLocation string = ''

resource swa 'Microsoft.Web/staticSites@2022-03-01' = {
  name: swaName
  location: location
  sku: {
    name: swaSku
    tier: swaSku
  }
  properties: {
    repositoryUrl: repositoryUrl
    branch: branch
    repositoryToken: repositoryToken
    buildProperties: {
      appLocation: appLocation
      apiLocation: apiLocation
      appArtifactLocation: appArtifactLocation
    }
  }
}
