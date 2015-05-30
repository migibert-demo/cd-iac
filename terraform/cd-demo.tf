provider "openstack" {
    insecure = true
}

variable "router_id" {
    default = "43b9ef97-2d8f-44c9-b943-8b1425a38d25"
}

variable "keypair_name" {
    default = "cd-demo"
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

resource "openstack_compute_instance_v2" "instance-gocd-master" {
    name = "gocd-master"
    image_name = "ubuntu-14.04_x86_64"
    flavor_name = "1_vCPU_RAM_512M_HD_10G"
    key_pair = "${var.keypair_name}"
    network = {
        uuid = "${openstack_networking_network_v2.cd-net.id}"
    }
    depends_on = ["openstack_networking_router_interface_v2.net-interface-cd"]
}

resource "openstack_compute_instance_v2" "instance-gocd-slave-1" {
    name = "gocd-slave-1"
    image_name = "ubuntu-14.04_x86_64"
    flavor_name = "1_vCPU_RAM_512M_HD_10G"
    key_pair = "${var.keypair_name}"
    network = {
        uuid = "${openstack_networking_network_v2.cd-net.id}"
    }
    depends_on = ["openstack_networking_router_interface_v2.net-interface-cd"]
}

resource "openstack_compute_instance_v2" "instance-gocd-slave-2" {
    name = "gocd-slave-2"
    image_name = "ubuntu-14.04_x86_64"
    flavor_name = "1_vCPU_RAM_512M_HD_10G"
    key_pair = "${var.keypair_name}"
    network = {
        uuid = "${openstack_networking_network_v2.cd-net.id}"
    }
    depends_on = ["openstack_networking_router_interface_v2.net-interface-cd"]
}

resource "openstack_compute_instance_v2" "instance-gocd-slave-3" {
    name = "gocd-slave-3"
    image_name = "ubuntu-14.04_x86_64"
    flavor_name = "1_vCPU_RAM_512M_HD_10G"
    key_pair = "${var.keypair_name}"
    network = {
        uuid = "${openstack_networking_network_v2.cd-net.id}"
    }
    depends_on = ["openstack_networking_router_interface_v2.net-interface-cd"]
}

output "output" {
    value = "gocd-master: ${openstack_compute_instance_v2.instance-gocd-master.access_ip_v4}\ngocd-slaves: ${openstack_compute_instance_v2.instance-gocd-slave-1.access_ip_v4},${openstack_compute_instance_v2.instance-gocd-slave-2.access_ip_v4},${openstack_compute_instance_v2.instance-gocd-slave-3.access_ip_v4}"
}