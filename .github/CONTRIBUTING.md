# Contributing to terraform-tls-pki

## Local checks

Install the pinned development tools and run the same hooks used in CI:

```bash
mise trust
mise install
mise exec -- pre-commit install
mise exec -- pre-commit run --all-files
```

The hooks format and validate Terraform, regenerate module documentation, lint
GitHub Actions with actionlint and Zizmor, validate Renovate and Mergify
configuration, and check file formatting. Terraform validation initializes the
root module and both examples with current providers allowed by their constraints.
It does not apply resources or create certificates.

The module and examples support Terraform `~> 1.0`; `.mise.toml` pins the current
development version. CI discovers all three Terraform roots, validates each with
its minimum supported Terraform version, and runs all hooks with the maximum
supported version. The aggregate `Pre-commit checks` job succeeds only if every
required job succeeds, including the entire minimum-version matrix.

Provider lock files are intentionally ignored for this reusable module and its
examples. Consumers should commit their own root configuration's lock file.

## Pull requests and releases

Use a Conventional Commit PR title with one of these types:

- `feat`: new features
- `fix`: bug fixes
- `docs`: documentation and examples
- `refactor`: restructuring without changing behavior
- `test`: test changes
- `ci`: CI changes
- `chore`: maintenance

Update the examples and generated documentation when changing module inputs or
outputs. Run the hooks again after they rewrite files.

PRs into `main` are squash-merged after approval and successful checks. PRs into
`release` use merge commits to retain the conventional commit messages from
`main`. Pushes to `release` run semantic-release with the full Git history to
publish version tags and release notes. Do not commit generated private keys,
certificate bundles, or Terraform state.

## Dependency updates and automatic merging

Renovate opens dependency PRs, pins GitHub Actions to commit SHAs, and rebases
branches when they fall behind `main`. Mergify handles approval and merging;
Renovate's `automerge` and `platformAutomerge` remain disabled.

- GitHub Actions, mise tools, and pre-commit hooks receive `automerge-candidate`
  for minor, patch, digest, and digest-pinning updates.
- Terraform provider/module updates and major updates require human approval.
- All Mergify approval and merge paths require `Pre-commit checks` and
  `Validate PR title` to succeed.
- Drafts, requested changes, and `do-not-merge` block automatic approval and merging.
- Removing `automerge-candidate`, or adding `update-major` or `breaking-change`,
  blocks Renovate automatic approval and merging. The general merge rules require
  a human approval, so an earlier bot approval cannot bypass these restrictions.

To enforce these checks for manual merges too, configure GitHub protection for
`main` and `release` to require `Pre-commit checks` and `Validate PR title` from
GitHub Actions after those checks have run. Keep the approval requirement; Mergify
provides approval for eligible Renovate updates.
