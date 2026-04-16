#################################################################################################### 
#   terraform.tf                                                                                   # 
####################################################################################################

terraform {
  required_version = "~> 1.14.0"
  required_providers {
    github = {
      source  = "integrations/github"
    }
    time = {
      source  = "hashicorp/time"
    }
  }
}