variable "aws_region" {
  type    = string
  default = "ap-northeast-1"
}

variable "project_name" {
  type    = string
  default = "terraform-demo"
}

variable "env" {
  type    = string
  default = "dev"
}

variable "test" {
  type    = string
  default = "test"
}