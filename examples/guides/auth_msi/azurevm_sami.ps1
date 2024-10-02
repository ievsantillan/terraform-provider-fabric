# See https://learn.microsoft.com/entra/identity/managed-identities-azure-resources/how-to-configure-managed-identities?pivots=qs-configure-powershell-windows-vm#system-assigned-managed-identity for more details.

# Assign the system-assigned managed identity to the VM
# See https://learn.microsoft.com/powershell/module/az.compute/get-azvm for more details.
$vm = Get-AzVM -ResourceGroupName "<RESOURCE GROUP NAME>" -Name "<VM NAME>"
# See https://learn.microsoft.com/powershell/module/az.compute/update-azvm for more details.
Update-AzVM -ResourceGroupName "<RESOURCE GROUP NAME>" -VM $vm -IdentityType SystemAssigned

# Assign Contributor role for the system-assigned managed identity to the Fabric Capacity
# See https://learn.microsoft.com/azure/role-based-access-control/role-assignments-powershell for more details.
New-AzRoleAssignment -ObjectId "<PRINCIPAL ID>" -RoleDefinitionName Contributor -Scope "/subscriptions/<SUBSCRIPTION ID>/resourceGroups/<RESROURCE GROUP NAME>/providers/Microsoft.Fabric/capacities/<FABRIC CAPACITY NAME>"

# Get current admin members and add a new principal to the array
# See https://learn.microsoft.com/powershell/module/az.accounts/invoke-azrestmethod for more details.
$members = ((Invoke-AzRestMethod -Method GET -Path "/subscriptions/<SUBSCRIPTION ID>/resourceGroups/<RESROURCE GROUP NAME>/providers/Microsoft.Fabric/capacities/<FABRIC CAPACITY NAME>?api-version=2023-11-01").Content | ConvertFrom-Json).properties.administration.members += "<PRINCIPAL ID>"

# Update the Fabric Capacity with the new admin members
$payload = @{
	properties = @{
		administration = @{
			members = $members
		}
	}
} | ConvertTo-Json -Depth 10
Invoke-AzRestMethod -Method PATCH -Path "/subscriptions/<SUBSCRIPTION ID>/resourceGroups/<RESROURCE GROUP NAME>/providers/Microsoft.Fabric/capacities/<FABRIC CAPACITY NAME>?api-version=2023-11-01" -Payload $payload
