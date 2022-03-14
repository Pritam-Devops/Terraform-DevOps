provider "aws" {
  profile = "Admin"
  region  = "ap-south-1"
}

resource "aws_iam_user" "u1" {
  name = "user1"

}

resource "aws_instance" "server" {
  count           = 4 # create four similar instances
  ami             = "ami-0e0ff68cb8e9a188a"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.TerrSG.name]

  tags = {
    Name = "Server ${count.index}"
  }
}

resource "aws_security_group" "TerrSG" {
  name        = "TSG"
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-0ecee780f1ee98939"

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "deval"
  }
}
