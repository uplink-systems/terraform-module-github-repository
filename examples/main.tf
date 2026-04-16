####################################################################################################
#   provider.tf                                                                                    # 
####################################################################################################

module "private-repository" {
  source        = "github.com/uplink-systems/terraform-module-github-repository"
  repository    = {
    name                  = "private-repository"
    description           = "private repository created by Terraform"
    gitignore_template    = "VisualStudio"
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
    