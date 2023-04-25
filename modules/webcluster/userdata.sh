#!/bin/bash
echo ${print_text} > index.html
nohup busybox httpd -f -p ${var.server_port} &