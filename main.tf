provider "aws" {
  region = "eu-west-1" 
}

resource "aws_vpc" "tf_vpc" {
  cidr_block = "10.0.0.0/16" 
    tags = {
        Name = "My-first-vpc"
    } 
}

resource "aws_internet_gateway" "tf_igw" {
vpc_id = aws_vpc.tf_vpc.id 
    tags = {
        Name = "My-first-igw"
    } 
}

resource "aws_route_table" "tf_rt" {
  vpc_id = aws_vpc.tf_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_igw.id
  }
      tags = {
        Name = "My-first-rt"
    } 
}

resource "aws_route_table" "tf_rt1" {
  vpc_id = aws_vpc.tf_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_igw.id
  }
      tags = {
        Name = "My-first-rt"
    } 
}
resource "aws_route_table_association" "tf_subnet_assosiation1" {
  subnet_id = aws_subnet.tf_subnet1.id
  route_table_id = aws_route_table.tf_rt.id
}

resource "aws_route_table_association" "tf_subnet_assosiation2" {
  subnet_id = aws_subnet.tf_subnet2.id
  route_table_id = aws_route_table.tf_rt.id
}

resource "aws_subnet" "tf_subnet1" {
  vpc_id = aws_vpc.tf_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-west-1a"
}

resource "aws_subnet" "tf_subnet2" {
  vpc_id = aws_vpc.tf_vpc.id
  cidr_block = "10.0.30.0/24"
  availability_zone = "eu-west-1b"
}

resource "aws_subnet" "tf_subnet3" {
  vpc_id = aws_vpc.tf_vpc.id
  cidr_block = "10.0.70.0/24"
  availability_zone = "eu-west-1c"
}
resource "aws_security_group" "tf_sg" {
    vpc_id = aws_vpc.tf_vpc.id
    name = "terraform-sg1"
    description = "SG used for SSH"
    # Inbound rule for ssh (port 22)
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    # Inbound rule for HTTP (port 80)
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
 
resource "aws_instance" "terraform-instance1" {
  ami           = "ami-07355fe79b493752d" 
  instance_type = "t2.micro"  
  subnet_id = aws_subnet.tf_subnet1.id
  vpc_security_group_ids = ["sg-09eedc87ceb7361c2"]
  tags = {
        Name = "My-first-tf-instance"
    }     
}

resource "aws_instance" "terraform-instance2" {
  ami           = "ami-07355fe79b493752d" 
  instance_type = "t2.micro"
  subnet_id = aws_subnet.tf_subnet2.id
  vpc_security_group_ids = ["sg-09eedc87ceb7361c2"]
  tags = {
        Name = "My-Second-tf-instance"
    }  
}




