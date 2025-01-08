param rgName string
param location string

module virtualNetwork 'br/public:avm/res/network/virtual-network:0.4.0' = {
  name: '${rgName}-vnet'
  params: {
    addressPrefixes: [
      '10.1.0.0/16'  // Expanded address space for the VNet
    ]
    name: '${rgName}-vnet'
    location: location
    subnets: [
      {
        name: 'AzureFirewallSubnet'
        addressPrefix: '10.1.1.0/24'  // Valid range within the expanded VNet
      }
      {
        addressPrefix: '10.1.2.0/26'  // Valid range within the expanded VNet
        name: 'AzureBastionSubnet'
      }
    ]
  }
}

output vnetId string = virtualNetwork.outputs.resourceId
