resource "openstack_networking_network_v2" "network_ipi" {
  name           = "${var.start}-network_ipi"
  admin_state_up = "true"
  tenant_id      = openstack_identity_project_v3.ipi_project.id
}

resource "openstack_networking_subnet_v2" "subnet_ipi" {
  name       = "${var.start}-subnet_ipi"
  network_id = openstack_networking_network_v2.network_ipi.id
  cidr       = "10.0.0.0/24"
  ip_version = 4
}