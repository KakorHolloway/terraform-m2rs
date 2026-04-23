data "openstack_identity_role_v3" "reader" {
    name = "reader"
}

resource "openstack_identity_role_assignment_v3" "ipi_role_assignment" {
  user_id    = openstack_identity_user_v3.ipi_user.id
  project_id = openstack_identity_project_v3.ipi_project.id
  role_id    = data.openstack_identity_role_v3.reader.id
}