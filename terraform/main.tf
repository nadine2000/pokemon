terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Create VPC and networking
resource "aws_vpc" "pokemon_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(var.tags, {
    Name = "pokemon-vpc"
  })
}

resource "aws_internet_gateway" "pokemon_igw" {
  vpc_id = aws_vpc.pokemon_vpc.id

  tags = merge(var.tags, {
    Name = "pokemon-igw"
  })
}

resource "aws_subnet" "pokemon_subnet" {
  vpc_id                  = aws_vpc.pokemon_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = "pokemon-subnet"
  })
}

resource "aws_route_table" "pokemon_rt" {
  vpc_id = aws_vpc.pokemon_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.pokemon_igw.id
  }

  tags = merge(var.tags, {
    Name = "pokemon-route-table"
  })
}

resource "aws_route_table_association" "pokemon_rta" {
  subnet_id      = aws_subnet.pokemon_subnet.id
  route_table_id = aws_route_table.pokemon_rt.id
}

resource "aws_security_group" "pokemon_sg" {
  name_prefix = "pokemon-sg-"
  vpc_id      = aws_vpc.pokemon_vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Custom App Port"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "pokemon-security-group"
  })
}

# DynamoDB Module
module "dynamodb" {
  source = "./dynamodb"

  table_name   = var.dynamodb_table_name
  billing_mode = var.billing_mode
  hash_key     = var.hash_key
  tags         = var.tags
}

# EC2 Module
module "ec2" {
  source = "./ec2"

  instance_type        = var.instance_type
  key_name            = var.key_name
  subnet_id           = aws_subnet.pokemon_subnet.id
  security_group_ids  = [aws_security_group.pokemon_sg.id]
  dynamodb_table_name = module.dynamodb.table_name
  aws_region          = var.aws_region
  tags                = var.tags
}