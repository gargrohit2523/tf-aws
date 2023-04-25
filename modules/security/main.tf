resource "aws_security_group" "tf-sg-1" {
    name = "terraform-sg-1"

    ingress {
        from_port = var.server_port
        to_port = var.server_port
        protocol = "tcp"
        cidr_blocks = local.allips
    }
}

locals {
  allips = ["0.0.0.0/0"]
  defaultserverport = 8080
}