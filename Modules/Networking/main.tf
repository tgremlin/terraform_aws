module "subnet_addrs" {
  source = "hashicorp/subnets/cidr"

  base_cidr_block   = "10.0.0.0/16"
  networks          = [
      {
          name         = "us-west-2a"
          new_bits     = 10
      },
      {
          name         = "us-west-2b"
          new_bits     = 10
      },
      {
          name         = "us-west-2c"
          new_bits     = 10
      },
      {
          name         = "us-west-2d"
          new_bits     = 8
      },

  ]
  
}

resource "aws_vpc" "vpc" {
  cidr_block = module.subnet_addrs.base_cidr_block

tags = {
  name = var.vpc_name
}

}

resource "aws_subnet" "subnets" {
  for_each          = module.subnet_addrs.network_cidr_blocks

  vpc_id            = aws_vpc.vpc.id
  availability_zone = each.key
  cidr_block        = each.value
tags = {
      Name = "${var.vpc_name}-${each.key}-subnet"
}  

}

resource "aws_internet_gateway" "vpc_gateway" {
  vpc_id    = aws_vpc.vpc.id

tags = {
  Name = "${var.vpc_name}-IGW"
}

}

resource "aws_route" "vpc_route" {
  route_table_id          = aws_vpc.vpc.main_route_table_id
  destination_cidr_block  = var.all_ip_cidr
  gateway_id              = aws_internet_gateway.vpc_gateway.id

}  

resource "aws_security_group" "default" {
  name          = "http-https-allow"
  description   = "Allows incoming and outgoing HTTP and HTTPS connections"
  vpc_id        = aws_vpc.vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.Ingress_CIDR_Block
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.Ingress_CIDR_Block
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.Ingress_CIDR_Block
  }

  egress  {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = var.Egress_CIDR_Block
  }
  
tags = {
  Name = "${var.vpc_name}-SG"
}  
}


