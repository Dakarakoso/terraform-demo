variable "tfc_org_name" {
  type    = string
  default = "learn-terraform-willian-maruyama"
}

variable "tfc_token" {
  type      = string
  sensitive = true
  default   = null
}

variable "tfc_project_id" {
  type    = string
  default = null
}

variable "github_vcs_oath_token_id" {
  type      = string
  sensitive = true
  default   = null
}