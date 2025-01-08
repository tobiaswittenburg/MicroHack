param location string
param virtualWanName string

module virtualWan 'br/public:avm/res/network/virtual-wan:0.3.0' = {
  name: 'virtualWanDeployment'
  params: {
    // Required parameters
    name: virtualWanName
    // Non-required parameters
    location: location
  }
}

output virtualWanId string = virtualWan.outputs.resourceId
