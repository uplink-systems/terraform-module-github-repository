####################################################################################################
#   provider.tf                                                                                    # 
####################################################################################################

module "private-repository-simple" {
  source        = "github.com/uplink-systems/terraform-module-github-repository"
  repository    = {
    name                  = "private-repository-simple"
    description           = "private repository-simple created by Terraform"
  }
}

module "public-repository" {
  source        = "github.com/uplink-systems/terraform-module-github-repository"
  repository    = {
    name                  = "public-repository"
    description           = "public repository created by Terraform"
    gitignore_template    = "C++"
    has_issues            = true
    license_template      = "eupl-1.2"
    topics                = ["open-source","code"]
    visibility            = "public"
  }
}

module "public-repository-with-all-optional-features-configured" {
  source                = "github.com/uplink-systems/terraform-module-github-repository"
  repository            = {
    name                    = "public-repository-with-all-optional-features-configured"
    description             = "public repository-with-all-optional-features-configured created by Terraform"
    gitignore_template      = "Terraform"
    has_issues              = true
    license_template        = "eupl-1.2"
    topics                  = ["terraform","iac"]
    visibility              = "public"
  }
  branch                = [
    { branch = "dev", source_branch = "main"},
    { branch = "pre-release", source_branch = "dev"},
  ]
  branch_default        = {
    branch                    = "dev"
  }
  repository_milestone  = {
    "test_stage_reached"      = { owner = var.github.owner, title = "Test stage reached", description = "Steps/issues/tasks to reach Test stage", state = "closed" }
    "release_stage_reached"   = { owner = var.github.owner, title = "Release stage reached", description = "Steps/issues/tasks to reach Release stage", due_date = "2025-12-31",  }
  }
 }