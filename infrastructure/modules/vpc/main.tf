# Set up VPC
resource "aws_vpc" "app_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.vpc_name}-vpc"
  }
}

# Set up SUBNETS
resource "aws_subnet" "app_public_subnet_list" {
  count             = length(var.app_service_subnets)
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = var.app_service_subnets[count.index].cidr_block
  availability_zone = var.app_service_subnets[count.index].availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.vpc_name}-subnet-${count.index}"
  }
}

resource "aws_subnet" "app_elb_subnet_list" {
  count             = length(var.app_elb_subnets)
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = var.app_elb_subnets[count.index].cidr_block
  availability_zone = var.app_elb_subnets[count.index].availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.vpc_name}-elb-${count.index}"
  }
}

#Set up GATEWAY
resource "aws_internet_gateway" "app_internet_gateway" {
  vpc_id = aws_vpc.app_vpc.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

# Set up route table
resource "aws_route_table" "app_public_rt" {
  vpc_id = aws_vpc.app_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.app_internet_gateway.id
  }
  tags = {
    Name = "${var.vpc_name}-public-rt"
  }
}

resource "aws_route_table" "app_private_rt" {
  vpc_id = aws_vpc.app_vpc.id

  tags = {
    Name = "${var.vpc_name}-private-rt"
  }
}

resource "aws_route_table_association" "app_public_associate_table" {
  count = length(aws_subnet.app_public_subnet_list)

  subnet_id      = aws_subnet.app_public_subnet_list[count.index].id
  route_table_id = aws_route_table.app_public_rt.id
}

resource "aws_route_table_association" "app_elb_associate_table" {
  count = length(aws_subnet.app_elb_subnet_list)

  subnet_id      = aws_subnet.app_elb_subnet_list[count.index].id
  route_table_id = aws_route_table.app_public_rt.id
}

# Set up security group
resource "aws_security_group" "app_service_sg" {
  name   = "${var.vpc_name}-service-sg"
  vpc_id = aws_vpc.app_vpc.id

  egress {
    description      = "Allow all out traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.vpc_name}-servive-sg"
  }
}

resource "aws_security_group_rule" "app_ingress_rules" {
  count             = length(var.ingress_ports)
  security_group_id = aws_security_group.app_service_sg.id

  from_port         = var.ingress_ports[count.index]
  to_port           = var.ingress_ports[count.index]
  protocol          = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  type              = "ingress"
}

resource "aws_security_group" "app_service_elb_sg" {
  name   = "${var.vpc_name}-service-elb-sg"
  vpc_id = aws_vpc.app_vpc.id

  ingress {
    description      = "Allow http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "Allow https"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description      = "Allow all out traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.vpc_name}-service-elb-sg"
  }
}
