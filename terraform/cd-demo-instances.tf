resource "openstack_compute_instance_v2" "instance-orchestrator" {
    name = "orchestrator"
    image_name = "ubuntu-14.04_x86_64"
    flavor_name = "1_vCPU_RAM_512M_HD_10G"
    key_pair = "${var.keypair_name}"
    floating_ip = "${openstack_networking_floatingip_v2.orchestrator_floating_ip.address}"
    network = {
        uuid = "${openstack_networking_network_v2.cd-net.id}"
    }
    depends_on = ["openstack_networking_router_interface_v2.net-interface-cd"]
    depends_on = ["openstack_networking_floatingip_v2.orchestrator_floating_ip.address"]
}

resource "openstack_compute_instance_v2" "instance-gocd-master" {
    name = "gocd-master"
    image_name = "ubuntu-14.04_x86_64"
    flavor_name = "1_vCPU_RAM_1G_HD_10G"
    key_pair = "${var.keypair_name}"
    floating_ip = "${openstack_networking_floatingip_v2.gocd_master_floating_ip.address}"
    network = {
        uuid = "${openstack_networking_network_v2.cd-net.id}"
    }
    depends_on = ["openstack_networking_router_interface_v2.net-interface-cd"]
}

resource "openstack_compute_instance_v2" "instance-gocd-slave-1" {
    name = "gocd-slave-1"
    image_name = "ubuntu-14.04_x86_64"
    flavor_name = "1_vCPU_RAM_1G_HD_10G"
    key_pair = "${var.keypair_name}"
    network = {
        uuid = "${openstack_networking_network_v2.cd-net.id}"
    }
    depends_on = ["openstack_networking_router_interface_v2.net-interface-cd"]
}

resource "openstack_compute_instance_v2" "instance-gocd-slave-2" {
    name = "gocd-slave-2"
    image_name = "ubuntu-14.04_x86_64"
    flavor_name = "1_vCPU_RAM_1G_HD_10G"
    key_pair = "${var.keypair_name}"
    network = {
        uuid = "${openstack_networking_network_v2.cd-net.id}"
    }
    depends_on = ["openstack_networking_router_interface_v2.net-interface-cd"]
}

resource "openstack_compute_instance_v2" "instance-gocd-slave-3" {
    name = "gocd-slave-3"
    image_name = "ubuntu-14.04_x86_64"
    flavor_name = "1_vCPU_RAM_1G_HD_10G"
    key_pair = "${var.keypair_name}"
    network = {
        uuid = "${openstack_networking_network_v2.cd-net.id}"
    }
    depends_on = ["openstack_networking_router_interface_v2.net-interface-cd"]
}

output "output" {
    value = "gocd-master: ${openstack_compute_instance_v2.instance-gocd-master.access_ip_v4}\ngocd-slaves: ${openstack_compute_instance_v2.instance-gocd-slave-1.access_ip_v4},${openstack_compute_instance_v2.instance-gocd-slave-2.access_ip_v4},${openstack_compute_instance_v2.instance-gocd-slave-3.access_ip_v4}"
}

output "orchestrator" {
    value = "${openstack_networking_floatingip_v2.orchestrator_floating_ip.address}"
}
