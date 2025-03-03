
@description('Resource name of the storage account to which permissions are to be granted')
param storage_name string

@description('Resource group of the storage account')
param storage_rg string

@description('Managed Identity of the resource being granted permissions')
param principalId string

@description('Flag to grant Storage Blob Data Reader role to the storage account')
param grant_reader bool = true

@description('Flag to grant Storage Blob Data Contributor role to the storage account')
param grant_contributor bool = true

// Get reference to storage account
resource storage_account 'Microsoft.Storage/storageAccounts@2023-01-01' existing = {
  name: storage_name
  scope: resourceGroup(storage_rg)
}

// Role Definition IDs (Built-in)
var sbdcRoleDefinitionId = '/providers/Microsoft.Authorization/roleDefinitions/ba92f5b4-2d11-453d-a403-e96b0029c9fe'
var sbdrRoleDefinitionId = '/providers/Microsoft.Authorization/roleDefinitions/acdd72a7-3385-48ef-bd42-f606fba81ae7'

// Grant Storage Blob Data Contributor role to the resource
resource grant_sbdc_role 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = if (grant_contributor) {
  name: guid(storage_account.id, principalId, sbdcRoleDefinitionId)
  scope: storage_account
  properties: {
    principalType: 'ServicePrincipal'
    principalId: principalId
    roleDefinitionId: '${storage_account.id}${sbdcRoleDefinitionId}'
  }
}

// Grant Storage Blob Data Reader role to the resource
resource grant_sbdr_role 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = if (grant_reader) {
  name: guid(storage_account.id, principalId, sbdrRoleDefinitionId)
  scope: storage_account
  properties: {
    principalType: 'ServicePrincipal'
    principalId: principalId
    roleDefinitionId: '${storage_account.id}${sbdrRoleDefinitionId}'
  }
}
