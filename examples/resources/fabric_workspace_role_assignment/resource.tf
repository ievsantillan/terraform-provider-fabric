resource "fabric_workspace_role_assignment" "example" {
  workspace_id   = "00000000-0000-0000-0000-000000000000"
  principal_id   = "11111111-1111-1111-1111-111111111111"
  principal_type = "User"
  role           = "Member"
}
