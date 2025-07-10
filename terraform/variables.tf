variable "github_token" {
  type        = string
  description = "GitHub Personal Access Token"
  sensitive   = true
}

variable "key_name" {
  description = "Name of the existing EC2 key pair"
  default     = "MyFirstKeyPair"
}

