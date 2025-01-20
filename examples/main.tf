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
    has_issues            = false
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
  issue_label = {
    merge                     = true
    label                     = [
      { name = "first custom label", color = "123456", description = "This is the first custom label for example purpose."},
      { name = "second custom label", color = "F0F0F0", description = "This is a second custom label for example purpose."},
    ]
  }
  issue = [
    { title = "bug with docu", body = "## Bug with Docu<br>Description of the bug...", labels = ["bug", "documentation"],  },
    { title = "new feature", body = "##New Feature<br>Request description...", labels = ["enhancement"], assignees = ["github-example-user-1","github-example-user-2"], milestone_number = 2 }
  ]
 }