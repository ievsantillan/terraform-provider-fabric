# PowerShell
$env:FABRIC_TENANT_ID = '00000000-0000-0000-0000-000000000000'
$env:FABRIC_CLIENT_ID = '00000000-0000-0000-0000-000000000000'
$env:FABRIC_CLIENT_CERTIFICATE = [System.Convert]::ToBase64String([System.IO.File]::ReadAllBytes('C:\Users\myusername\Documents\my\client\bundle.pfx'))
$env:FABRIC_CLIENT_CERTIFICATE_PASSWORD = 'YourBundlePassword'
