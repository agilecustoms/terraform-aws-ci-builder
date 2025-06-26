variable "account_id" {
  description = "AWS account id"
}

variable "codeartifact_domain_name" {
  description = "CodeArtifact domain, typically just a company name"
}

variable "iam_policy_path" {
  default     = "/ci/"
  description = "use path to differentiate application roles, user roles and CI roles"
}

variable "iam_policy_name" {
  default = "builder"
}

variable "partition" {
  default     = "aws"
  description = "AWS partition, e.g. aws, aws-cn, aws-us-gov"
}

variable "region" {
  description = "AWS region"
}
