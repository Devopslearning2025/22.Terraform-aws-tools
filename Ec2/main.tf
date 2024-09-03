module "Ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "Ec2"

  instance_type          = "t3.micro"
  vpc_security_group_ids = ["sg-06b06924b4097241d"]
  subnet_id              = "subnet-0ed5d7f5043e97d3e"
  user_data              = file("docker.sh")
  ami                    = data.aws_ami.ami_info.id

  tags = {
    Name = "Ec2"
  }
}

#Create R53 record for Ec2 URL

# module "records" {
#   source  = "terraform-aws-modules/route53/aws//modules/records"
#   version = "~> 2.0"

#   zone_name = var.zone_name

#   records = [
#     {
#       name    = "Ec2"
#       type    = "A"
#       ttl     = 1
#       allow_overwrite = true
#       records = [
#         module.Ec2.public_ip
#       ]
#     }
#   ]
# }