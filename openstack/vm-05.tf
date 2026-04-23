resource "openstack_networking_port_v2" "port_ipi_1" {
  name               = "${var.start}-port_1-${var.env}"
  network_id         = openstack_networking_network_v2.network_ipi.id
  admin_state_up     = "true"

  fixed_ip {
    subnet_id  = openstack_networking_subnet_v2.subnet_ipi.id
    ip_address = "10.0.0.12"
  }
}

resource "openstack_compute_instance_v2" "instance_ipi_1" {
  name            = "${var.start}-instance_ipi_1-${var.env}"
  security_groups = ["default"]
  flavor_id       = "84"
  image_id        = "c73156f6-ed6c-4546-ace4-33ee78f81663"

  network {
    port = openstack_networking_port_v2.port_ipi_1.id
  }
}