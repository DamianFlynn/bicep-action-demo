targetScope = 'subscription'

@description('Azure region for all resources.')
param location string = deployment().location

@description('Short name used in every resource name.')
param workload string = 'demo'

@description('Tags applied to every resource.')
param tags object = {}

resource rg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: 'rg-bicep-action-${workload}'
  location: location
  tags: tags
}

module monitoring 'modules/monitoring.bicep' = {
  name: 'monitoring'
  scope: rg
  params: {
    location: location
    workload: workload
    tags: tags
  }
}

output resourceGroupName string = rg.name
output storageAccountName string = monitoring.outputs.storageAccountName
