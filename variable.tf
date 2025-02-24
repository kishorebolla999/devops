variable "aws_region" {
  description = "AWS region"
  default     = "us-east-2" 
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  default     = "ami-0fc82f4dabc05670b"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  default     = "linux key"
}

variable "environment" {
  description = "Environment (dev, prod, etc.)"
  default     = "dev"
}
