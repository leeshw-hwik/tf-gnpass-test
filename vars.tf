variable "AMI" {
  type = map(string)

  default = {
    ap-northeast-2 = "ami-01711d925a1e4cc3a"
  }
}

variable "AWS_REGION" {
  default = "ap-northeast-2"
}

variable "PRIVATE_KEY_PATH" {
  default = "seoul-region-key-pair"
}

variable "PUBLIC_KEY_PATH" {
  default = "seoul-region-key-pair.pub"
}

variable "EC2_USER" {
  default = "ec2-user"
}
