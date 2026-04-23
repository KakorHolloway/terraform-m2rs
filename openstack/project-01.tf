resource "openstack_identity_project_v3" "ipi_project" {
  name        = "${var.start}-TERRAFORM-${var.env}"
  description = "test_project"
}