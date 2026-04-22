resource "openstack_identity_project_v3" "ipi_project" {
  name        = "TERRAFORM"
  description = "test_project"
}