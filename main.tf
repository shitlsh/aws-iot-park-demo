terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.13"
}

provider "aws" {
  region = "us-west-2"
}

module "iot-simulator" {
  source = "./modules/iot-simulator"
  user_email = "tailong.shi@thoughtworks.com"
}