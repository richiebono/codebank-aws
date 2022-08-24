terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.15.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }

  required_version = "~> 1.2.0"
  
  backend "s3" {
      bucket = "bono-terraform-tfstate-bucket"
      key    = "codebank-terraform.tfstate"
      region = "us-east-1"
    }


}

