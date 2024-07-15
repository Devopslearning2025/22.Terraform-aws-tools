module "jenkins" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "jenkins"

  instance_type          = "t3.micro"
  vpc_security_group_ids = ["sg-06b06924b4097241d"]
  subnet_id              = "subnet-0ed5d7f5043e97d3e"
  user_data              = file("jenkins.sh")
  ami                    = data.aws_ami.ami_info.id

  tags = {
    Name = "Jenkins"
  }
}

module "jenkins_agent" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "jenkins-Agent"

  instance_type          = "t3.micro"
  vpc_security_group_ids = ["sg-06b06924b4097241d"]
  subnet_id              = "subnet-0ed5d7f5043e97d3e"
  user_data              = file("jenkins-agent.sh")
  ami                    = data.aws_ami.ami_info.id
  tags = {
    Name = "Jenkins-Agent"
  }
}
# resource "aws_key_pair" "tools" {
#   key_name   = "tools"
#   ## We can paste the key value like below or we can give the path if the file 
#   ## public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
#   public_key = file(" ~/.ssh/tools.pub")
# }

# module "nexus" {
#   source  = "terraform-aws-modules/ec2-instance/aws"
 
#   name = "nexus"

#   instance_type          = "t3.micro"
#   vpc_security_group_ids = ["sg-06b06924b4097241d"]
#   subnet_id              = "subnet-0ed5d7f5043e97d3e"
#   ami                    = data.aws_ami.nexus_ami_info.id
#   key_name               = aws_key_pair.tools.key_name
#   root_block_device      = [
#     {
#       volume_type = "gp3"
#       volume_size = 10
#     }
#   ]
#   tags = {
#     Name = "nexus"
#   }
# }

#Create R53 record for jenkins URL

module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 2.0"

  zone_name = var.zone_name

  records = [
    {
      name    = "jenkins"
      type    = "A"
      ttl     = 1
      allow_overwrite = true
      records = [
        module.jenkins.public_ip
      ]
    },
    {
      name    = "jenkins-agent"
      type    = "A"
      ttl     = 1
      allow_overwrite = true
      records = [
        module.jenkins_agent.private_ip
      ]
    },
    # {
    #   name    = "nexus"
    #   type    = "A"
    #   ttl     = 1
    #   allow_overwrite = true
    #   records = [
    #     module.nexus.private_ip
    #   ]
    # }
  ]
}