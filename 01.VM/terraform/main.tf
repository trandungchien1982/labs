# Khai báo biến, lấy từ khai báo trong 00.provision-vm.sh
# TF_VAR_VM_NAME
resource "multipass_instance" "vm" {
  name   = "vm-labs"
  cpus   = 4
  memory = "6G"
  disk   = "40G"
  image  = "24.04" # 24.04 LTS
  cloudinit_file = "${path.module}/cloud-init.yaml"
}

output "vm_ip" {
  value = multipass_instance.vm.ipv4
}
