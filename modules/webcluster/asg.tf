resource "aws_autoscaling_group" "tf-web-asg" {
    launch_configuration = aws_launch_configuration.tf-launchConfig.name
    vpc_zone_identifier = data.aws_subnets.default.ids

    min_size = var.min
    max_size = var.max

    health_check_type = "ELB"

    load_balancers = [
      "${aws_lb.web_elb.id}"
    ]

    tag {
      key = "name"
      value = "tf-asg"
      propagate_at_launch = true
    }    
}