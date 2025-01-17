## Module 'terraform-module-github-repository'

### Description

The **terraform-module-github-repository** is intended to create and manage GitHub repository resources following my business needs standards.  
This includes the following guidelines:  
* Repository names  
  * Names of GitHub repositories are lowercase and can contain the following characters only:  
    * "a-z", "0-9", ".", "-"  

### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_github"></a> [integrations\/github](#requirement\_github) | ~> 6.0 |
| <a name="requirement_time"></a> [hashicorp\/time](#requirement\_time) | ~> 0.12 |

### Resources

| Name | Type |
|------|------|
| [github_repository.repository](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |
| [github_repository_collaborator.collaborator](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_collaborator) | resource |
| [github_team_repository.team](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_repository) | resource |
| [github_branch.branch](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch) | resource |
| [github_branch_default.branch_default](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_default) | resource |
| [time_offset.offset](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/offset) | resource |
| [github_repository_milestone.milestone](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_milestone) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_repository"></a> [repository](#input\_repository) | 'var.repository' is the main variable for github_repository resource settings | <pre>type        = object({<br>  name                                    = string<br>  description                             = optional(string, null)<br>  allow_auto_merge                        = optional(bool, false)<br>  allow_merge_commit                      = optional(bool, true)<br>  allow_rebase_merge                      = optional(bool, true)<br>  allow_squash_merge                      = optional(bool, true)<br>  allow_update_branch                     = optional(bool, false)<br>  archive_on_destroy                      = optional(bool, null)<br>  archived                                = optional(bool, null)<br>  auto_init                               = optional(bool, true)<br>  delete_branch_on_merge                  = optional(bool, false)<br>  gitignore_template                      = optional(string, null)<br>  has_discussions                         = optional(bool, false)<br>  has_downloads                           = optional(bool, false)<br>  has_issues                              = optional(bool, false)<br>  has_projects                            = optional(bool, false)<br>  has_wiki                                = optional(bool, false)<br>  homepage_url                            = optional(string, null)<br>  ignore_vulnerability_alerts_during_read = optional(bool, false)<br>  is_template                             = optional(bool, false)<br>  license_template                        = optional(string, null)<br>  pages                                   = optional(any, null)<br>  security_and_analysis                   = optional(any, null)<br>  template                                = optional(object({<br>    owner                                   = string<br>    repository                              = string<br>    include_all_branches                    = optional(bool, false)<br>  }), null)<br>  topics                                  = optional(list(string), null)<br>  visibility                              = optional(string, null)<br>  vulnerability_alerts                    = optional(bool, null)<br>  web_commit_signoff_required             = optional(bool, false)<br>})<br></pre> | none | yes |
| <a name="input_collaborator"></a> [collaborator](#input\_collaborator) | 'var.collaborator' specifies lists of different collaborator types for the repository | <pre>type        = object({<br>  enabled     = optional(bool, true)<br>  admin       = optional(list(string), [])<br>  maintain    = optional(list(string), [])<br>  pull        = optional(list(string), [])<br>  push        = optional(list(string), [])<br>  triage      = optional(list(string), [])<br>})<br></pre> |<pre>{ enabled = false }</pre> | no |
| <a name="input_team"></a> [team](#input\_team) | 'var.team' specifies lists of different team names for the repository | <pre>type        = object({<br>  enabled     = optional(bool, true)<br>  admin       = optional(list(string), [])<br>  maintain    = optional(list(string), [])<br>  pull        = optional(list(string), [])<br>  push        = optional(list(string), [])<br>  triage      = optional(list(string), [])<br>})<br></pre> | <pre>{ enabled = false }</pre> | no |
| <a name="input_branch"></a> [branch](#input\_branch) | 'var.branch' is the optional variable for additional github_branch resource settings | <pre>type        = list(object({<br>  branch          = string<br>  source_branch   = optional(string, null)<br>  source_sha      = optional(string, null)<br>}))<br></pre> | <pre>[ ]</pre> | no |
| <a name="input_branch_default"></a> [branch\_default](#input\_branch\_default) | 'var.branch_default' is the optional variable for the github_branch_default resource settings | <pre>type        = object({<br>  branch      = string<br>})<br></pre> | none | no |
| <a name="input_repository_milestone"></a> [repository\_milestone](#input\_repository\_milestone) | 'var.repository_milestone' is the optional variable for the github_repository_milestone resource settings | <pre>type        = map(object({<br>  owner           = string<br>  title           = string<br>  description     = optional(string, null)<br>  due_date        = optional(string, null)<br>  state           = optional(string, "open")<br>}))<br></pre> | <pre>{ }</pre> | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_github_repository"></a> [github\_repository](#output\_github\_repository) | list of all exported attributes values from the repository resource(s) |
| <a name="output_github_repository_collaborator"></a> [github\_repository\_collaborator](#output\_github\_repository\_collaborator) | list of all exported attributes values from the repository_collaborator resource(s) |
| <a name="output_github_team_repository"></a> [github\_team\_repository](#output\_github\_team\_repository) | list of all exported attributes values from the team_repository resource(s) |
| <a name="output_github_branch"></a> [github\_branch](#output\_github\_branch) | list of all exported attributes values from the branch resource(s) |
| <a name="output_github_branch_default"></a> [github\_branch\_default](#output\_github\_branch\_default) | list of all exported attributes values from the branch_default resource(s) |
| <a name="output_github_repository_milestone"></a> [github\_repository\_milestone](#output\_github\_repository\_milestone) | list of all exported attributes values from the repository_milestone resource(s) |
  
### Known Issues

<details>
<summary><b>Repository for 'GitHub pages'</b></summary>

######
The module currently does not allow to create a repository for GitHub pages. This is on hold as GitHub retired one of the deployment types.
######
</details>

<details>
<summary><b>'Error 422' after changing <i>security_and_analysis</i> values</b></summary>

######
Changing security_and_analysis' state attributes from "enabled" to "disabled" or vice versa can lead to Error 422 during apply, e.g.:  
*Error: PATCH https://api.github.com/repos/{GitHub-Id}/{Repository}: 422 Secret scanning is not available for this repository. []*  
This is a known issue of the GitHub provider (see: https://github.com/integrations/terraform-provider-github/issues/2145).
 and occurs using this module in the following cases:  
* GitHub Actions is disabled on repository level or on organization level.  
* The repositories visibiliy is changed from 'private' to 'public'. The error occurs because the feature is not yet available when the visibility change is applied. A second apply is needed to change the 'security_and_analysis' values.   
The module is configured to apply security_and_analysis features only if 'var.repository.visibiliy' is configured to 'public' because AAdvanced Security for private repositories and its depended features is only available for enterprise accounts on GitHub Enterprise Cloud and GitHub Enterprise Server whereas the module is intended for non-enterprise environments. For private repositories the state values are 'null' and cannot be enabled to prevent to enable security_and_analysis feature to a repository where the features are not available.   
  
######
</details>

<details>
<summary><b>Variable 'branch_default'</b></summary>

######
The variable 'branch_default' is unset (null) by default and if no other values are specified. In this case the 'main' branch is configured as default. Setting the variable to another branch can only be done after a repository has already been created, and after a correct reference has been created for the target branch inside the repository. This means a user will have to omit this parameter from the initial repository creation and create the target branch inside of the repository prior to setting this attribute.  
######
</details>
