terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.6"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "test-ec2" {
    ami = "ami-006e00d6ac75d2ebb"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.sg_1.id]
    subnet_id = "subnet-0fe17325922f331dc"

    user_data = <<-EOF
                #!/bin/bash
                echo "\n\n Welcome ming" > index.html
                nohup busybox httpd -fp 8080 &
                EOF
    tags = {
        Name  ="terraform-example"
    }
}

resource "aws_security_group" "sg_1" {
    name = "allow_8080"
    vpc_id = "vpc-05f555509488c66b6"
    ingress {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks  = ["0.0.0.0/0"]
    }
  
}