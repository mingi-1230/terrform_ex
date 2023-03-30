output "aws_instance" {
    value = aws_instance.test-ec2.instance_type
    description = "ec2 type print"
}