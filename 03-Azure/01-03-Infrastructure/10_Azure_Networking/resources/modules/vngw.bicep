param location string
param virtualHubResourceId string
param name string

module vpnGateway 'br/public:avm/res/network/vpn-gateway:0.1.3' = {
  name: 'vpnGatewayDeployment'
  params: {
    // Required parameters
    name: name
    virtualHubResourceId: virtualHubResourceId
    // Non-required parameters
    location: location
    bgpSettings: {
      asn: 65515
      peerWeight: 0
    }
  }
}
output vpnGatewayId string = vpnGateway.outputs.resourceId
