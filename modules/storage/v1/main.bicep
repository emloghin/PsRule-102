
param name string = deployment().name

param location string = resourceGroup().location

param sku string

resource storage 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: name
  location: location
  sku: {
    name: sku
  }
  kind: 'StorageV2'
  properties:{
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
    allowBlobPublicAccess: false
  }
}

resource blobservice 'Microsoft.Storage/storageAccounts/blobServices@2022-09-01' = {
  parent: storage
  name: 'default'
  properties:{
    deleteRetentionPolicy:{
       enabled: true
       days: 7
    }
    containerDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }   
  }
}

resource filesServices 'Microsoft.Storage/storageAccounts/fileServices@2022-09-01' = {
  parent: storage
  name: 'default'
  properties: {
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}
