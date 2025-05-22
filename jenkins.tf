# Instance
resource "aws_instance" "jenkins" {
  ami           = var.ami["debian"]
  instance_type = var.instance_type
  tags = {
    "Name" : "Jenkins"
    "Application" : "Jenkins"
  }
  user_data = file("./scripts/jenkinsInstall.sh")
  security_groups = [aws_security_group.jenkins_sg.name]
}

# Security group
resource "aws_security_group" "jenkins_sg" {
  name = "jenkins_sg"
  description = "Allow port 8080 inbound and all outbound"
  tags = {
    Name : "Jenkins_SG"
  }
}

# Security group outbound rule
resource "aws_vpc_security_group_ingress_rule" "allow_8080" {
  security_group_id = aws_security_group.jenkins_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = "8080"
  to_port = "8080"
  ip_protocol = "tcp"
}

# Security group outbound rule
resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.jenkins_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
}