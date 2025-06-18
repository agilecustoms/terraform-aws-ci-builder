data "aws_iam_policy_document" "builder_codeartifact" {
  statement {
    effect = "Allow"
    actions = [
      "codeartifact:GetAuthorizationToken",
    ]
    resources = [
      "arn:${var.partition}:codeartifact:${var.region}:${var.account_id}:domain/${var.codeartifact_domain_name}",
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "codeartifact:GetRepositoryEndpoint",
      "codeartifact:ReadFromRepository",
    ]
    resources = [
      "arn:${var.partition}:codeartifact:${var.region}:${var.account_id}:repository/${var.codeartifact_domain_name}/*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "sts:GetServiceBearerToken",
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      values   = ["codeartifact.amazonaws.com"]
      variable = "sts:AWSServiceName"
    }
  }
}

data "aws_iam_policy_document" "builder" {
  source_policy_documents = concat(
    data.aws_iam_policy_document.builder_codeartifact.json,
  )
}

resource "aws_iam_policy" "builder" {
  path   = var.iam_path
  name   = var.iam_role_name
  policy = data.aws_iam_policy_document.builder.json
}
