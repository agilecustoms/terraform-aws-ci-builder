[![Terraform Registry][terraform-registry-badge]][terraform-registry]
[![License][license-badge]][license]

# terraform-aws-ci-builder

IAM policy `/ci/builder` for building applications that rely on software packages stored in CodeArtifact.
Originally designed to be used in CI pipelines by GitHub action
[agilecustoms/setup-maven-codeartifact][setup-maven-codeartifact]

The policy allows `codeartifact:ReadFromRepository` from all CodeArtifact repositories in a specified domain

To publish artifacts to S3, ECR and CodeArtifact, see another module
[terraform-aws-ci-publisher][terraform-aws-ci-publisher]

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

### How to create a role with this policy

This module creates just policy, and here is a _recommendation_ how to create a role.
For roles used in CI pipelines, it is highly recommended to use an OIDC provider rather than IAM user credentials.
See [terraform-aws-ci-publisher][terraform-aws-ci-publisher] for an example

### Inputs

| Name                     | Required | Default | Description                                             |
|--------------------------|----------|---------|---------------------------------------------------------|
| account_id               | yes      |         | AWS account ID where the CodeArtifact domain is located |
| codeartifact_domain_name | yes      |         | CodeArtifact domain, typically just a company name      |
| iam_policy_path          | no       | /ci/    | Use path to differentiate application/user/CI roles     |
| iam_policy_name          | no       | builder | Name of the IAM policy                                  |
| partition                | no       | aws     | AWS partition, e.g. aws, aws-cn, aws-us-gov             |
| region                   | yes      |         | AWS region where CodeArtifact is located                |

### Outputs

| Name       | Description                                  |
|------------|----------------------------------------------|
| policy_arn | ARN of the IAM policy created by this module |

## Requirements

| Name      | Version   |
|-----------|-----------|
| terraform | >= 1.5.7  |
| aws       | >= 3.38.0 |

## Providers

| Name | Version   |
|------|-----------|
| aws  | >= 3.38.0 |

## Modules

No modules.

## Resources

| Name                                     | Type     |
|------------------------------------------|----------|
| [aws_iam_policy.builder][aws-iam-policy] | resource |

## Authors

Module is maintained by [Alexey Chekulaev][alexey-chekulaev]

## License

Apache 2 Licensed. See [LICENSE][license] for full details

## Copyright

Copyright 2025 [Alexey Chekulaev][alexey-chekulaev]

[alexey-chekulaev]: https://github.com/laxa1986
[aws-iam-policy]: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/aws_iam_policy
[license]: https://github.com/agilecustoms/terraform-aws-ci-builder/blob/main/LICENSE
[license-badge]: https://img.shields.io/github/license/agilecustoms/terraform-aws-ci-builder
[setup-maven-codeartifact]: https://github.com/agilecustoms/setup-maven-codeartifact
[terraform-aws-ci-publisher]: https://github.com/agilecustoms/terraform-aws-ci-publisher
[terraform-registry]: https://registry.terraform.io/modules/agilecustoms/ci-builder/aws/latest
[terraform-registry-badge]: https://img.shields.io/badge/Terraform-Module-blue.svg
