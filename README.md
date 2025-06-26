# terraform-aws-ci-builder
IAM policy `/ci/builder` to build applications relying on software packages stored in CodeArtifact

The policy allows `codeartifact:ReadFromRepository` from all CodeArtifact repositories in a specified domain

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
| Name                     | Default | Description                                                                         |
|--------------------------|---------|-------------------------------------------------------------------------------------|
| account_id               |         | (required) AWS account id where all artifacts are stored (S3, ECR, CodeArtifact)    |
| codeartifact_domain_name |         | (required) CodeArtifact domain, typically just a company name. Keep empty if unused |
| iam_policy_path          | /ci/    | Use path to differentiate application/user/CI roles                                 |
| iam_policy_name          | builder | Name of the IAM policy                                                              |
| partition                | aws     | AWS partition, e.g. aws, aws-cn, aws-us-gov                                         |
| region                   |         | (required) AWS region where CodeArtifact is located                                 |

## Outputs
| Name        | Description                      |
|-------------|----------------------------------|
| policy_arn  | ARN of a policy that was created |

## How to create a role with this policy
This module creates just policy, and here is a _recommendation_ how to create a role.
For roles used in CI pipelines, it is highly recommended to use OIDC provider, not IAM user with credentials.
See [terraform-aws-ci-publisher](https://github.com/agilecustoms/terraform-aws-ci-publisher) for an example.
