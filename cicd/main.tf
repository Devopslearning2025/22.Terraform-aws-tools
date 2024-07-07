module "jenkins" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "jenkins"

  instance_type          = "t3.micro"
  vpc_security_group_ids = ["sg-12345678"]
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
  vpc_security_group_ids = ["sg-12345678"]
  subnet_id              = "subnet-0ed5d7f5043e97d3e"
  user_data              = file("jenkins-agent.sh")
  ami                    = data.aws_ami.ami_info.id
  tags = {
    Name = "Jenkins-Agent"
  }
}

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
    }
  ]
}