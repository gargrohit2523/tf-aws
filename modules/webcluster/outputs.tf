output "elb-dns" {
  value = aws_lb.web_elb.dns_name
}