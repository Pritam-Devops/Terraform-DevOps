resource "aws_iam_user" "u2" {
  name = "user2"

}

resource "aws_instance" "server01" {
 # count             = 4 # create four similar EC2 instances
  ami               = "ami-0e0ff68cb8e9a188a"
  availability_zone = "ap-south-1a"
  instance_type     = "t2.micro"
  security_groups   = [aws_security_group.TerrSG.name]


  #tags = {
  #  Name = "Server ${count.index}"
  #}
}

resource "aws_security_group" "TerrSG-01" {
  name        = "TSG-01"
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


resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.vol1.id
  instance_id = aws_instance.server01.id
}
resource "aws_ebs_volume" "vol1" {
  availability_zone = "ap-south-1a"
  size              = 1
}
