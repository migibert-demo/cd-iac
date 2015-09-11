provider "openstack" {
    insecure = true
}

variable "router_id" {
    default = "43b9ef97-2d8f-44c9-b943-8b1425a38d25"
}

variable "keypair_name" {
    default = "cd-demo"
}

variable "floatingip_pool" {
    default = "PublicNetwork-02"
}


resource "openstack_networking_network_v2" "cd-net" {
    name = "cd-net"
}

resource "openstack_networking_subnet_v2" "cd-subnet" {
    network_id = "${openstack_networking_network_v2.cd-net.id}"
    cidr = "192.168.10.0/24"
    ip_version = 4
}

resource "openstack_networking_router_interface_v2" "net-interface-cd" {
    router_id = "${var.router_id}"
    subnet_id = "${openstack_networking_subnet_v2.cd-subnet.id}"
}

resource "openstack_networking_network_v2" "integration-net" {
    name = "integration-net"
}

resource "openstack_networking_subnet_v2" "integration-subnet" {
    network_id = "${openstack_networking_network_v2.integration-net.id}"
    cidr = "192.168.20.0/24"
    ip_version = 4
}

resource "openstack_networking_router_interface_v2" "net-interface-integration" {
    router_id = "${var.router_id}"
    subnet_id = "${openstack_networking_subnet_v2.integration-subnet.id}"
}

resource "openstack_networking_network_v2" "preproduction-net" {
    name = "preproduction-net"
}

resource "openstack_networking_subnet_v2" "preproduction-subnet" {
    network_id = "${openstack_networking_network_v2.preproduction-net.id}"
    cidr = "192.168.30.0/24"
    ip_version = 4
}

resource "openstack_networking_router_interface_v2" "net-interface-preproduction" {
    router_id = "${var.router_id}"
    subnet_id = "${openstack_networking_subnet_v2.preproduction-subnet.id}"
}

resource "openstack_networking_network_v2" "performance-net" {
    name = "performance-net"
}

resource "openstack_networking_subnet_v2" "performance-subnet" {
    network_id = "${openstack_networking_network_v2.performance-net.id}"
    cidr = "192.168.40.0/24"
    ip_version = 4
}

resource "openstack_networking_router_interface_v2" "net-interface-performance" {
    router_id = "${var.router_id}"
    subnet_id = "${openstack_networking_subnet_v2.performance-subnet.id}"
}

resource "openstack_networking_network_v2" "production-net" {
    name = "production-net"
}

resource "openstack_networking_subnet_v2" "production-subnet" {
    network_id = "${openstack_networking_network_v2.production-net.id}"
    cidr = "192.168.50.0/24"
    ip_version = 4
}

resource "openstack_networking_router_interface_v2" "net-interface-production" {
    router_id = "${var.router_id}"
    subnet_id = "${openstack_networking_subnet_v2.production-subnet.id}"
}

resource "openstack_networking_floatingip_v2" "orchestrator_floating_ip" {
    pool = "${var.floatingip_pool}"
}

resource "openstack_networking_floatingip_v2" "gocd_master_floating_ip" {
    pool = "${var.floatingip_pool}"
}

