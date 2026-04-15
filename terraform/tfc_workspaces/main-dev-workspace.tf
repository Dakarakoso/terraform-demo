module "dev-learn-terraform-workspace" {
  source  = "app.terraform.io/learn-terraform-willian-maruyama/workspace/tfe"
  version = "2.1.0"

  tfc_org_name = var.tfc_org_name

  tfc_project_id        = var.tfc_project_id
  workspace_name        = "tfc-prj-learn-terraform-dev"
  workspace_description = "This is the development workspace for the learn terraform project"
  terraform_version     = "1.14.8"
  tag_names             = ["account:prj-learn-terraform", "env:dev"]
  assessment_enabled    = true

  workspace_vcs_repo {
    github {
      oauth_token_id             = var.github_vcs_oath_token_id
      identifier                 = "willian-maruyama/learn-terraform"
      branch                     = "dev"
      ingress_submodules         = false
      github_app_installation_id = null
      tags_regex                 = null
    }
  }

  trigger_patterns = [
    "/terraform/dev/**/*.tf",
    "/terraform/modules/**/*.tf",
  ]
  working_directory = "/terraform/dev/"

  is_used_aws_dynamic_credentials = true
  aws_provider_run_arn            = "arn:aws:iam::896725786105:role/mng-iam-role-tfc-oidc-project"
}