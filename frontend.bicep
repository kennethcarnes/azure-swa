// frontend.bicep

// Parameters needed for the Static Web App
param SWAName string
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

// Parameters needed for the CDN
@description('Name of the CDN Profile')
param profileName string

@description('Name of the CDN Endpoint, must be unique')
param endpointName string

@description('CDN SKU names')
@allowed([
  'Standard_Akamai'
  'Standard_Microsoft'
  'Standard_Verizon'
  'Premium_Verizon'
])
param CDNSku string = 'Standard_Microsoft'

resource swaResource 'Microsoft.Web/staticSites@2021-01-01' = {
  name: SWAName
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

resource profile 'Microsoft.Cdn/profiles@2021-06-01' = {
  name: profileName
  location: location
  sku: {
    name: CDNSku
  }
}

resource endpoint 'Microsoft.Cdn/profiles/endpoints@2021-06-01' = {
  parent: profile
  name: endpointName
  location: location
  properties: {
    originHostHeader: swaResource.properties.defaultHostname
    isHttpAllowed: true
    isHttpsAllowed: true
    isCompressionEnabled: true
    origins: [
      {
        name: 'origin1'
        properties: {
          hostName: swaResource.properties.defaultHostname
        }
      }
    ]
  }
}
