provider "aws" {
    region = "ap-south-1"
}

resource "aws_launch_configuration" "tf-launchConfig" {
   name_prefix = "tf-launchConfig-"
   image_id = "ami-0325e3016099f9112"
   instance_type = "t2.micro"  
   security_groups = [aws_security_group.tf-sg-1.id]
   user_data = <<-EOF
             #!/bin/bash
             echo "Hello, World" > index.html
             nohup busybox httpd -f -p ${var.server_port} &
             EOF
   lifecycle {
     create_before_destroy = true
   }

}

resource "aws_autoscaling_group" "tf-asg" {
    launch_configuration = aws_launch_configuration.tf-launchConfig.name
    vpc_zone_identifier = data.aws_subnets.default.ids

    min_size = 2
    max_size = 6

    tag {
      key = "name"
      value = "tf-asg"
      propagate_at_launch = true
    }    
}

data "aws_vpc" "default" {
    default = true
}

data "aws_subnets" "default" {
    filter {
      name = "vpc-id"
      values = [data.aws_vpc.default.id]
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

