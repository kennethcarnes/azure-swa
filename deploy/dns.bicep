param defaultHostname string

resource zone 'Microsoft.Network/dnsZones@2018-05-01' = {
  name: 'customDomain'
  location: 'global'

  resource cnameRecord 'CNAME@2018-05-01' = {
    name: 'www'
    properties: {
      TTL: 3600
      CNAMERecord: {
        cname: defaultHostname
      }
    }
  }
}
