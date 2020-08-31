output "worker" {
  value = aws_instance.worker*.public_ip
}
output "controlplane" {
  value = aws_instance.controlplane*.public_ip
}
