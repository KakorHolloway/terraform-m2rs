resource "openstack_identity_user_v3" "ipi_user" {
  default_project_id = openstack_identity_project_v3.ipi_project.id
  name               = "${var.start}-ipi_user-${var.env}"
  description        = "A user"
 
  password = "B4teau123!"
 
  ignore_change_password_upon_first_use = true
 
  multi_factor_auth_enabled = false
}
