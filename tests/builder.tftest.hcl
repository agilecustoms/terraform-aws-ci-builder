# Plan-only tests: aws_iam_policy_document is evaluated locally, so no AWS credentials are needed

provider "aws" {
  region                      = "us-east-1"
  access_key                  = "mock"
  secret_key                  = "mock"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
}

variables {
  account_id               = "123456789012"
  region                   = "us-east-1"
  codeartifact_domain_name = "acme"
}

run "defaults" {
  command = plan

  assert {
    condition     = aws_iam_policy.builder.name == "builder" && aws_iam_policy.builder.path == "/ci/"
    error_message = "Policy must be /ci/builder by default"
  }

  assert {
    condition = alltrue([for a in ["codeartifact:GetAuthorizationToken", "codeartifact:GetRepositoryEndpoint", "codeartifact:ReadFromRepository", "sts:GetServiceBearerToken"] :
      contains(flatten([for s in jsondecode(aws_iam_policy.builder.policy).Statement : s.Action]), a)
    ])
    error_message = "CodeArtifact read actions must be allowed"
  }

  assert {
    condition = alltrue([for a in flatten([for s in jsondecode(aws_iam_policy.builder.policy).Statement : s.Action]) :
      contains(["codeartifact:GetAuthorizationToken", "codeartifact:GetRepositoryEndpoint", "codeartifact:ReadFromRepository", "sts:GetServiceBearerToken"], a)
    ])
    error_message = "Builder must be read-only: no actions besides reading CodeArtifact (ex: no PublishPackageVersion)"
  }

  assert {
    condition = alltrue([for r in ["arn:aws:codeartifact:us-east-1:123456789012:domain/acme", "arn:aws:codeartifact:us-east-1:123456789012:repository/acme/*"] :
      contains(flatten([for s in jsondecode(aws_iam_policy.builder.policy).Statement : s.Resource]), r)
    ])
    error_message = "CodeArtifact resources must be scoped to the domain and its repositories"
  }

  assert {
    condition = anytrue([for s in jsondecode(aws_iam_policy.builder.policy).Statement :
      contains(flatten([s.Action]), "sts:GetServiceBearerToken")
      && try(s.Condition.StringEquals["sts:AWSServiceName"], null) == "codeartifact.amazonaws.com"
    ])
    error_message = "sts:GetServiceBearerToken must be limited to CodeArtifact"
  }
}

run "custom_name_and_partition" {
  command = plan

  variables {
    iam_policy_name = "acme-builder"
    iam_policy_path = "/build/"
    partition       = "aws-cn"
  }

  assert {
    condition     = aws_iam_policy.builder.name == "acme-builder" && aws_iam_policy.builder.path == "/build/"
    error_message = "Policy name and path must come from variables"
  }

  assert {
    condition = alltrue([for r in flatten([for s in jsondecode(aws_iam_policy.builder.policy).Statement : s.Resource]) :
      r == "*" || startswith(r, "arn:aws-cn:")
    ])
    error_message = "All ARNs must use the given partition"
  }
}
