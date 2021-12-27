output "bowtie-vm" {
  value = "${google_compute_instance.bowtie-VM.name}"
  description = "VM name"
}

output "VPC" {
  value = "${google_compute_network.vpc.name}"
  description = "VPC name"
}


output "firewall" {
  value = "${google_compute_firewall.bowtie-fw.name}"
}

output "IP-bowtie" {
  value = "${google_compute_instance.bowtie-VM.network_interface.0.access_config}"
}