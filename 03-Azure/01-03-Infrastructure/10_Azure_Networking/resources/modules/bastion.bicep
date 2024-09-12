param location string
param bastionHostName string
param virtualNetworkResourceId string

// Public IP resourceId purposefully left empty as it is not required for the Bastion Host, will be created automatically
module bastionHost 'br/public:avm/res/network/bastion-host:0.3.0' = {
  name: bastionHostName
  scope: resourceGroup('basionTestRg')
  params: {
    name: bastionHostName
    location: location
    virtualNetworkResourceId: virtualNetworkResourceId // Provide the virtual network resource ID
    scaleUnits: 4
    skuName: 'Standard'
  }
}
