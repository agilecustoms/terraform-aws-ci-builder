variable "account_id" {
  description = "AWS account id where all artifacts are stored (S3, ECR, CodeArtifact)"
}

variable "codeartifact_domain_name" {
  default     = ""
  description = "CodeArtifact domain, typically just a company name. Keep default (empty) if you don't use CodeArtifact"
}

variable "iam_path" {
  default     = "/ci/"
  description = "use path to differentiate application roles, user roles and CI roles"
}

variable "iam_role_name" {
  default = "builder"
}

variable "partition" {
  default     = "aws"
  description = "AWS partition, e.g. aws, aws-cn, aws-us-gov"
}

variable "region" {
  description = "AWS region where all artifacts are stored (S3, ECR, CodeArtifact)"
}
