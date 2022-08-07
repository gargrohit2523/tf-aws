provider "aws" {  
    region = "ap-south-1"
}

resource "aws_instance" "tf-first-instance" {
    ami = "ami-0325e3016099f9112"
    instance_type = "t2.micro"  
    vpc_security_group_ids = [aws_security_group.tf-sg-1.id]

    user_data = <<-EOF
        #!/bin/bash
        echo "Hello World">index.html
        nohup busybox httpd -f -p 8080 &
        EOF

    tags = {
      "Name" = "tf-1"
    }
}

resource "aws_security_group" "tf-sg-1" {
    name = "terraform-sg-1"

    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }  
}