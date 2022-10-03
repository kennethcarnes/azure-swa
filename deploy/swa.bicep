param name string
@allowed([ 'centralus', 'eastus2', 'eastasia', 'westeurope', 'westus2' ])
param location string
@allowed([ 'Free', 'Standard' ])
param sku string = 'Standard'

resource swa_resource 'Microsoft.Web/staticSites@2021-01-15' = {
    name: name
    location: location
    tags: null
    properties: {
        branch: 'main'
        repositoryToken: 'repositoryToken'
        repositoryUrl: 'https://github.com/kennethcarnes/swa'
        buildProperties: {
            appLocation: '/' 
            apiLocation: './api'
            outputLocation: './output'
        }
    }

    sku: {
        name: sku
        size: sku
    }
}

