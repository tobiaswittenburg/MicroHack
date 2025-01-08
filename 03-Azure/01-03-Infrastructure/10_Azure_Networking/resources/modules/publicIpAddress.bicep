param name string
param location string = resourceGroup().location

module publicIpAddress 'br/public:avm/res/network/public-ip-address:0.5.1' = {
  name: 'publicIpAddressDeployment'
  params: {
    // Required parameters
    name: name
    // Non-required parameters
    location: location
  }
}

output publicIpAddress string = publicIpAddress.outputs.ipAddress
