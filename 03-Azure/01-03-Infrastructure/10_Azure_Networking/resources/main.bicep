param location1 string = 'swedencentral'
param location2 string = 'uksouth'

targetScope = 'subscription'

// Deploy resource groups in two regions
module primaryRg 'br/public:avm/res/resources/resource-group:0.3.0' = {
  name: 'primaryRg'
  params: {
    // Required parameters
    name: 'primaryRg'
    // Non-required parameters
    location: location1
  }
}

module secondaryRg 'br/public:avm/res/resources/resource-group:0.3.0' = {
  name: 'secondaryRg'
  params: {
    // Required parameters
    name: 'secondaryRg'
    // Non-required parameters
    location: location2
  }
}


// Deploy Virtual WAN in which the two hubs are deployed 
module virtualWan1 './modules/virtualwan.bicep' = {
  name: 'virtualWanModule1'
  scope: resourceGroup('primaryRg')
  params: {
    virtualWanName: 'virtualWan1'
    location: location1
  }
}



// Deploy Hubs in two regions
module hub1 './modules/hub.bicep' = {
  name: 'hubModule1'
  scope: resourceGroup('primaryRg')
  params: {
    name: 'hub1'
    addressprefix: '10.0.1.0/24'
    virtualWanId: virtualWan1.outputs.virtualWanId
  }
}

module hub2 './modules/hub.bicep' = {
  name: 'hubModule2'
  scope: resourceGroup('secondaryRg')
  params: {
    name: 'hub2'
    addressprefix: '10.0.2.0/24'
    virtualWanId: virtualWan1.outputs.virtualWanId
  }
}

// Deploy VNets in two regions
module vnet1 './modules/vnet.bicep' = {
  name: 'vnetModule1'
  scope: resourceGroup('primaryRg')
  params: {
    rgName: primaryRg.outputs.name
    location: location1
  }
}

module vnet2 './modules/vnet.bicep' = {
  name: 'vnetModule2'
  scope: resourceGroup('secondaryRg')
  params: {
    rgName: secondaryRg.outputs.name
    location: location2
  }
}



// Deploy Public IP Address in two regions
module publicIp1 './modules/publicIpAddress.bicep' = {
  name: 'publicIpModule1'
  scope: resourceGroup('primaryRg')
  params: {
    name: 'publicIp1'
    location: primaryRg.outputs.location
  }
}

module publicIp2 './modules/publicIpAddress.bicep' = {
  name: 'publicIpModule2'
  scope: resourceGroup('secondaryRg')
  params: {
    name: 'publicIp2'
    location: secondaryRg.outputs.location
  }
}


// Deploy Azure Firewall in two regions
module firewall1 './modules/firewall.bicep' = {
  name: 'firewallModule1'
  scope: resourceGroup('primaryRg')
  params: {
    fireWallpolicyName: 'firewallPolicy1'
    location: location1
    firewallName: 'firewall1'
    virtualHubId: hub1.outputs.virtualHubId
  }
}

module firewall2 './modules/firewall.bicep' = {
  name: 'firewallModule2'
  scope: resourceGroup('secondaryRg')
  params: {
    fireWallpolicyName: 'firewallPolicy2'
    location: location2
    firewallName: 'firewall2'
    virtualHubId: hub2.outputs.virtualHubId
  }
}


// Deploy Virtual Network Gateway with BGP Enablement
module vngw1 './modules/vngw.bicep' = {
  name: 'vngwModule1'
  scope: resourceGroup('primaryRg')
  params: {
    location: location1
    name: 'vngw1'
    virtualHubResourceId: hub1.outputs.virtualHubId
  }
}


module vngw2 './modules/vngw.bicep' = {
  name: 'vngwModule2'
  scope: resourceGroup('secondaryRg')
  params: {
    location: location2
    name: 'vngw2'
    virtualHubResourceId: hub2.outputs.virtualHubId
  }
}

module bastion1 './modules/bastion.bicep' = {
  name: 'bastionModule1'
  scope: resourceGroup('primaryRg')
  params: {
    location: location1
    bastionHostName: 'bastion1'  
    virtualNetworkResourceId: vnet1.outputs.vnetId
  }
}

module bastion2 './modules/bastion.bicep' = {
  name: 'bastionModule2'
  scope: resourceGroup('secondaryRg')
  params: {
    location: location2
    bastionHostName: 'bastion2'
    virtualNetworkResourceId: vnet2.outputs.vnetId
    }
}
