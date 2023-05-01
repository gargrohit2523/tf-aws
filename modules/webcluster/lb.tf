resource "aws_lb" "web_elb" {
  name = "web-cluster-elb"
  security_groups = ["${module.sg.sg_id}"]
  
  load_balancer_type = "application"

  access_logs {
    bucket  = "bn-dev-tf-state"
    prefix  = "web-lb"
    enabled = true
  }

  subnets = data.aws_subnets.default.ids

  cross_zone_load_balancing = true

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:80/"
  }
  
  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "80"
    instance_protocol = "http"
  }
}