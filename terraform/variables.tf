variable "github_owner" {
  description = "GitHub username or organization"
  default     = "Arjit-dev"
}

variable "github_repo" {
  description = "The GitHub repo to connect to CodePipeline"
  default     = "DevOps-Master-Project"
}

variable "github_branch" {
  description = "GitHub branch to trigger pipeline"
  default     = "main"
}

variable "artifact_bucket" {
  description = "Name of the S3 bucket for CodePipeline artifacts"
  default     = "devops-arjit-artifacts-123"
}

variable "github_token" {
  description = "GitHub Personal Access Token"
  type        = string
  sensitive   = true
}
