variable "account_id" {
  type        = string
  description = "AWS account id"
}

variable "codeartifact_domain_name" {
  type        = string
  description = "CodeArtifact domain, typically just a company name"
}

variable "iam_policy_path" {
  type        = string
  default     = "/ci/"
  description = "use path to differentiate application roles, user roles and CI roles"
}

variable "iam_policy_name" {
  type        = string
  default     = "builder"
  description = "Name of the IAM policy"
}

variable "partition" {
  type        = string
  default     = "aws"
  description = "AWS partition, e.g. aws, aws-cn, aws-us-gov"
}

variable "region" {
  type        = string
  description = "AWS region"
}
