terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.60"
    }

    null = {
      source  = "hashicorp/null"
      version = "~> 3.0.0"
    }
  }
}
