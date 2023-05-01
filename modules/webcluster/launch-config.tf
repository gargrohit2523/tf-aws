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