param fireWallpolicyName string
param location string
param firewallName string
param virtualHubId string

module firewallPolicy 'br/public:avm/res/network/firewall-policy:0.1.1' = {
  name: 'firewallPolicyDeployment'
  params: {
    // Required parameters
    name: fireWallpolicyName
    // Non-required parameters
    location: location
  } 
}

/*
module azureFirewall 'br/public:avm/res/network/azure-firewall:0.4.0' = {
  name: 'azureFirewallDeployment'
  params: {
    name: firewallName
    firewallPolicyId: firewallPolicy.outputs.resourceId
    azureSkuTier: 'Basic'
    location: location
    networkRuleCollections: []
    threatIntelMode: 'Deny'
    virtualNetworkResourceId: virtualNetworkResourceId
  }
}*/

module azureFirewall 'br/public:avm/res/network/azure-firewall:0.4.0' = {
  name: 'azureFirewallDeployment'
  params: {
    // Required parameters
    name: firewallName
    // Non-required parameters
    firewallPolicyId: firewallPolicy.outputs.resourceId
    hubIPAddresses: {
      publicIPs: {
        count: 1
      }
    }
    location: location
    virtualHubId: virtualHubId
  }
}
