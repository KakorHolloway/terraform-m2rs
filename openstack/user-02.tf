resource "openstack_identity_user_v3" "ipi_user" {
  default_project_id = openstack_identity_project_v3.ipi_project.id
  name               = "ipi_user"
  description        = "A user"
 
  password = "B4teau123!"
 
  ignore_change_password_upon_first_use = true
 
  multi_factor_auth_enabled = false
}

resource "openstack_identity_user_v3" "demo" {
  default_project_id = "83aede446dc44324b534bf8281715c07"
  name               = "demo"
  description        = ""
 
  password = "B4teau123!"
  extra = {
    email = "demo@example.com"
  }
 
  ignore_change_password_upon_first_use = true
 
  multi_factor_auth_enabled = false
}