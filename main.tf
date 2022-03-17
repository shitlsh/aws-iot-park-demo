terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "tailong"

    workspaces {
      name = "aws-iot-park-demo"
    }
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
  user_email = "tailong.shi@thoughtworks.com"
}