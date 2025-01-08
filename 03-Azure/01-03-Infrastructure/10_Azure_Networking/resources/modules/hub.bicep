param name string
param addressprefix string
param virtualWanId string

resource hub 'Microsoft.Network/virtualHubs@2020-04-01' = {
  name: name
  location: resourceGroup().location
  properties: {
    addressPrefix: addressprefix
    virtualWan: {
      id: virtualWanId
    }
  }
}

output virtualHubId string = hub.id
