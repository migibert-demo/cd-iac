provider "openstack" {
    insecure = true
}

variable "region" {
    default = "tr2"
}

variable "router_id" {
    default = {
        tr2 = "43b9ef97-2d8f-44c9-b943-8b1425a38d25"
    }
}

resource "openstack_networking_network_v2" "cd-net" {
    name = "cd-net"
}

resource "openstack_networking_subnet_v2" "cd-subnet" {
    network_id = "${openstack_networking_network_v2.cd-net.id}"
    cidr = "172.17.0.0/24"
    ip_version = 4
}

resource "openstack_networking_router_interface_v2" "net-interface-cd" {
    router_id = "${lookup(var.router_id, var.region)}"
    subnet_id = "${openstack_networking_subnet_v2.cd-subnet.id}"
}

resource "openstack_networking_network_v2" "integration-net" {
    name = "integration-net"
}

resource "openstack_networking_subnet_v2" "integration-subnet" {
    network_id = "${openstack_networking_network_v2.integration-net.id}"
    cidr = "172.17.1.0/24"
    ip_version = 4
}

resource "openstack_networking_router_interface_v2" "net-interface-integration" {
    router_id = "${lookup(var.router_id, var.region)}"
    subnet_id = "${openstack_networking_subnet_v2.integration-subnet.id}"
}


resource "openstack_networking_network_v2" "preproduction-net" {
    name = "cd-net"
}

resource "openstack_networking_subnet_v2" "preproduction-subnet" {
    network_id = "${openstack_networking_network_v2.preproduction-net.id}"
    cidr = "172.17.2.0/24"
    ip_version = 4
}

resource "openstack_networking_router_interface_v2" "net-interface-preproduction" {
    router_id = "${lookup(var.router_id, var.region)}"
    subnet_id = "${openstack_networking_subnet_v2.preproduction-subnet.id}"
}

resource "openstack_networking_network_v2" "performance-net" {
    name = "performance-net"
}

resource "openstack_networking_subnet_v2" "performance-subnet" {
    network_id = "${openstack_networking_network_v2.performance-net.id}"
    cidr = "172.17.3.0/24"
    ip_version = 4
}

resource "openstack_networking_router_interface_v2" "net-interface-performance" {
    router_id = "${lookup(var.router_id, var.region)}"
    subnet_id = "${openstack_networking_subnet_v2.performance-subnet.id}"
}

resource "openstack_networking_network_v2" "production-net" {
    name = "production-net"
}

resource "openstack_networking_subnet_v2" "production-subnet" {
    network_id = "${openstack_networking_network_v2.production-net.id}"
    cidr = "172.17.4.0/24"
    ip_version = 4
}

resource "openstack_networking_router_interface_v2" "net-interface-production" {
    router_id = "${lookup(var.router_id, var.region)}"
    subnet_id = "${openstack_networking_subnet_v2.production-subnet.id}"
}


