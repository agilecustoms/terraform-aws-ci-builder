# terraform-aws-ci-builder
IAM policy ci-builder to build (not publish) artifacts, has read access to CodeArtifact

## Usage
```hcl
module "builder_policy" {
  source = "git::https://github.com/agilecustoms/terraform-aws-ci-builder.git?ref=v1"

  account_id               = local.account_id
  codeartifact_domain_name = local.artifact_domain_name
  region                   = var.region
}
```

## Variables

| Name                     | Default   | Description                                                                         |
|--------------------------|-----------|-------------------------------------------------------------------------------------|
| account_id               |           | (required) AWS account id where all artifacts are stored (S3, ECR, CodeArtifact)    |
| codeartifact_domain_name |           | (required) CodeArtifact domain, typically just a company name. Keep empty if unused |
| iam_policy_path          | "/ci/"    | Use path to differentiate application/user/CI roles                                 |
| iam_policy_name          | "builder" | Name of the IAM policy                                                              |
| partition                | "aws"     | AWS partition, e.g. aws, aws-cn, aws-us-gov                                         |
| region                   |           | (required) AWS region where CodeArtifact is located                                 |

## Outputs

| Name        | Description                      |
|-------------|----------------------------------|
| policy_arn  | ARN of a policy that was created |
