output "worker" {
  value = aws_instance.worker[count.index].public_ip
}
output "controlplane" {
  value = aws_instance.controlplane[count.index].public_ip
}
