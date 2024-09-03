terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.2.1"
    }
  }
}

provider "github" {
  # Configuration options
}

resource "github_repository" "this" {
  name                      = var.repository_name
  visibility                = var.is_private
  allow_auto_merge          = true
  allow_rebase_merge        = true
  allow_squash_merge        = true
  squash_merge_commit_title = "PR_TITLE"
  allow_update_branch       = true
  delete_branch_on_merge    = true
}

resource "github_branch_default" "this" {
  repository = github_repository.this.name
  branch     = "main"
}

resource "github_actions_repository_permissions" "this" {
  allowed_actions = "selected"
  enabled         = true
  repository      = github_repository.this.name
  allowed_actions_config {
    github_owned_allowed = true
    patterns_allowed     = []
    verified_allowed     = true
  }
}

