resource "aws_launch_configuration" "tf-launchConfig" {
   name_prefix = "tf-launchConfig-"
   image_id = var.image_id
   instance_type = var.instance_type 
   security_groups = [module.sg.sg_id]
   user_data = data.template_file.user_data.rendered
   lifecycle {
     create_before_destroy = true
   }
}

data "template_file" "user_data" {
  template = file("${path.module}/userdata.tpl")

  vars = {
    server_port = var.server_port,
    print_text = var.print_text
  }
}

resource "aws_autoscaling_group" "tf-asg" {
    launch_configuration = aws_launch_configuration.tf-launchConfig.name
    vpc_zone_identifier = data.aws_subnets.default.ids

    min_size = var.min
    max_size = var.max

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

output "ec2_publicip" {
  value = "aws_instance.tf_first_instance.public_ip"
  description = "public ip of launched EC2 instance"
}

