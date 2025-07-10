provider "aws" {
  region = "ap-south-1"
}

provider "github" {
  token = var.github_token
}

