module "webcluster" {
  source = "../../../modules/webcluster"

  image_id = "ami-0325e3016099f9112"
  instance_type = "t2.micro"

  min = 2
  max = 4

  server_port = 8080
  print_text = "hello world"
}