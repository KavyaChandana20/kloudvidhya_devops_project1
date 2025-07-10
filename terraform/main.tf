# Security Group allowing SSH only between the instances
resource "aws_security_group" "internal_ssh" {
  name        = "allow-ssh-between-instances"
  description = "Allow SSH between Ansible and Jenkins"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "Allow SSH from same security group"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    self        = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_instance" "ansible_controller" {
  ami           = "ami-018046b953a698135"
  instance_type = "t2.micro"
  key_name      = var.key_name
  subnet_id     = data.aws_subnets.default.ids[0]
  vpc_security_group_ids = [aws_security_group.internal_ssh.id]


  tags = {
    Name = "AnsibleController"
  }
}

resource "aws_instance" "jenkins_server" {
  ami           = "ami-018046b953a698135"
  instance_type = "t2.micro"
  key_name      = var.key_name
  subnet_id     = data.aws_subnets.default.ids[0]
  vpc_security_group_ids = [aws_security_group.internal_ssh.id]

  tags = {
    Name = "JenkinsServer"
  }
}

resource "aws_ecr_repository" "kloudvidhya_repo" {
  name = "kloudvidhya_ecr_repo1"
}

resource "github_repository" "kloudvidhya_project" {
  name        = "kloudvidhya_devops_project1"
  description = "DevOps automation project"
  visibility  = "public"
  auto_init   = true
}

