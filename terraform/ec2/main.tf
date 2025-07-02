
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "pokemon_app" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name              = var.key_name
  subnet_id             = var.subnet_id
  vpc_security_group_ids = var.security_group_ids

  user_data = base64encode(templatefile("${path.root}/userdata.sh", {
    aws_region = var.aws_region
    table_name = var.dynamodb_table_name
  }))

  tags = merge(var.tags, {
    Name = "pokemon-app-instance"
  })
}