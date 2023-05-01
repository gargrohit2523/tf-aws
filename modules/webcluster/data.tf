data "template_file" "user_data" {
  template = file("${path.module}/userdata.tpl")

  vars = {
    server_port = var.server_port,
    print_text = var.print_text
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