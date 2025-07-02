variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-west-2"
}

variable "instance_type" {
  description = "EC2 instance type for the Pokemon application"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Name of the AWS Key Pair for EC2 SSH access"
  type        = string
  validation {
    condition     = length(var.key_name) > 0
    error_message = "Key name cannot be empty. Please provide a valid AWS Key Pair name."
  }
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table for Pokemon data"
  type        = string
  default     = "pokemon-table"
}

variable "billing_mode" {
  description = "DynamoDB billing mode (PAY_PER_REQUEST or PROVISIONED)"
  type        = string
  default     = "PAY_PER_REQUEST"
  validation {
    condition     = contains(["PAY_PER_REQUEST", "PROVISIONED"], var.billing_mode)
    error_message = "Billing mode must be either PAY_PER_REQUEST or PROVISIONED."
  }
}

variable "hash_key" {
  description = "Primary key for the DynamoDB table"
  type        = string
  default     = "id"
}

variable "tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    Project     = "Pokemon-App"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed to access the application"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}