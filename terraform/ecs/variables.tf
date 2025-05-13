variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}

variable "image_url" {
  type = string
  description = "ECR image URL for the app"
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}
