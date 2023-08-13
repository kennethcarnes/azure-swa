// Static Web App
param name string
param location string
param sku string
param skucode string
param repositoryUrl string
param branch string
@secure()
param repositoryToken string
param appLocation string
param apiLocation string
param appArtifactLocation string

resource name_resource 'Microsoft.Web/staticSites@2021-01-01' = {
  name: name
  location: location
  sku: {
    tier: sku
    name: skucode
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

// Azure CDN - Simplified for brevity. More configurations might be needed.
resource cdnProfile 'Microsoft.Cdn/profiles@2019-04-15' = {
  name: 'myCdnProfile'
  location: location
  sku: {
    name: 'Standard_Microsoft'
  }
}

resource cdnEndpoint 'Microsoft.Cdn/profiles/endpoints@2019-04-15' = {
  name: '${cdnProfile.name}/myCdnEndpoint'
  location: location
  properties: {
    originHostName: name_resource.properties.defaultHostname
    isHttpsAllowed: true
    originHostHeader: name_resource.properties.defaultHostname
  }
}
