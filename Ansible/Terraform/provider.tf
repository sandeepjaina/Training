terraform {
  backend "s3" {
    bucket = "sjaina-terraform"
    key = "Roboshop/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform_state"
  }
}

provider "aws" {
  region = "us-east-1"
}