module "webcluster" {
  source = "../../../modules/webcluster"

  image_id = "ami-02396cdd13e9a1257"
  instance_type = "t2.micro"

  min = 2
  max = 4

  server_port = 80
  print_text = "hello world"
}