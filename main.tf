provider "aws" {  
    region = "ap-south-1"
}

resource "aws_instance" "tf-first-instance" {
    ami = "ami-0325e3016099f9112"
    instance_type = "t2.micro"  
    vpc_security_group_ids = [aws_security_group.tf-sg-1.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF

  user_data_replace_on_change = true

    tags = {
      "Name" = "tf-1"
    }
}

resource "aws_security_group" "tf-sg-1" {
    name = "terraform-sg-1"

    ingress {
        from_port = var.server_port
        to_port = var.server_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

variable "server_port" {
  type = number
  default = 8080
  description = "server port to listen on"
}

output "ec2_publicip" {
  value = "aws_instance.tf_first_instance.public_ip"
  description = "public ip of launched EC2 instance"
}