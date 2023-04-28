variable "image_id" {
  type = string
  description = "image id of instance to launch"
}

variable "instance_type" {
  type = string
  description = "instance type to launch"
}

variable "server_port" {
  type = number
  description = "server port to listen on"
}

variable "print_text" {
  type = string
  description = "text to print"
}

variable "sg_ids" {
  type = list(string)
  description = "security group id to attach to instance"
  default = [""]
}

variable "min" {
  type = number
  description = "min size of the web cluster"
}

variable "max" {
  type = number
  description = "max size of the web cluster"
}