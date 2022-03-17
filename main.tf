terraform {
  backend "s3" {
    bucket = "aws-iot-tshi-tfstate"
    key    = "terraform/aws-iot-park-demo"
    region = "ap-southeast-2"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.13"
}

provider "aws" {
  region = "ap-southeast-2"
}

module "iot-device-simulator" {
  source     = "./modules/iot-device-simulator"
  user_email = var.my_email_address
}