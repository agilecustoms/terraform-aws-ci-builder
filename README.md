[![Terraform Registry](https://img.shields.io/badge/Terraform-Module-blue.svg)](https://registry.terraform.io/modules/agilecustoms/ci-builder/aws/latest)
[![License](https://img.shields.io/github/license/agilecustoms/terraform-aws-ci-builder)](https://github.com/agilecustoms/terraform-aws-ci-builder/blob/main/LICENSE)

# terraform-aws-ci-builder

## Overview

IAM policy `/ci/builder` for building applications that rely on software packages stored in CodeArtifact

The policy allows `codeartifact:ReadFromRepository` from all CodeArtifact repositories in a specified domain.

To publish artifacts to S3, ECR and CodeArtifact, see another module [terraform-aws-ci-publisher](https://github.com/agilecustoms/terraform-aws-ci-publisher)

## Highlights

- Grants minimal read access to CodeArtifact
- Supports GitHub Actions and other CI systems

## Usage

```hcl
module "builder_policy" {
  source = "agilecustoms/ci-builder/aws"

  account_id               = local.account_id
  codeartifact_domain_name = local.artifact_domain_name
  region                   = var.region
}
```

## How to create a role with this policy

This module creates just policy, and here is a _recommendation_ how to create a role.
For roles used in CI pipelines, it is highly recommended to use an OIDC provider rather than IAM user credentials.
See [terraform-aws-ci-publisher](https://github.com/agilecustoms/terraform-aws-ci-publisher) for an example.


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name                                                                      | Version   |
|---------------------------------------------------------------------------|-----------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.7  |
| <a name="requirement_aws"></a> [aws](#requirement\_aws)                   | >= 3.38.0 |

## Providers

| Name                                              | Version   |
|---------------------------------------------------|-----------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.38.0 |

## Modules

No modules.

## Resources

| Name                                                                                                                        | Type     |
|-----------------------------------------------------------------------------------------------------------------------------|----------|
| [aws_iam_policy.builder](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/aws_iam_policy)        | resource |

## Inputs

| Name                     | Default | Description                                                        |
|--------------------------|---------|--------------------------------------------------------------------|
| account_id               |         | (required) AWS account ID where the CodeArtifact domain is located |
| codeartifact_domain_name |         | (required) CodeArtifact domain, typically just a company name      |
| iam_policy_path          | /ci/    | Use path to differentiate application/user/CI roles                |
| iam_policy_name          | builder | Name of the IAM policy                                             |
| partition                | aws     | AWS partition, e.g. aws, aws-cn, aws-us-gov                        |
| region                   |         | (required) AWS region where CodeArtifact is located                |

## Outputs

| Name       | Description                                  |
|------------|----------------------------------------------|
| policy_arn | ARN of the IAM policy created by this module |

## Authors

Module is maintained by [Alexey Chekulaev](https://github.com/laxa1986)

## License

Apache 2 Licensed. See [LICENSE](https://github.com/agilecustoms/terraform-aws-ci-builder/blob/main/LICENSE) for full details

## Copyright

Copyright 2025 [Alexey Chekulaev](https://github.com/laxa1986)
