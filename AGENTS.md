# AGENTS.md

`README.md` is its public page (GitHub, Terraform Registry): only user-facing content goes there, internals are here

## Tech summary

- Language: Terraform
- Artifact: Terraform Registry module `agilecustoms/ci-builder/aws`, version = git tag `v{version}`,
  w/o floating tags (`floating-tags: false`), released by CI with *release* on push to `main`

## Context

*infrastructure-core* uses it for role `ci/builder` in the Dist account (`aws/account_dist/role-builder.tf`).
Read side of *setup-maven-codeartifact*, the publish side is *terraform-aws-ci-publisher*

## Changes

The module is public, others depend on it. There is no prerelease channel: `Validate` (lint, `terraform test`)
runs before `Release`, then every push to `main` is released. Users pin a version (no floating tags)

## Development

`make lint test-tf-validate test-tf`, all targets are in [Makefile](Makefile).
`test-tf` runs `terraform test` (`tests/builder.tftest.hcl`) with `command = plan` and a provider
that skips AWS credentials

## Documentation rules

- README Inputs table must match `variables.tf` (names, required, defaults), Outputs table must match `outputs.tf`
