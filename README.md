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
| [github_repository_collaborator.repository_collaborator](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_collaborator) | resource |
| [github_team_repository.team_repository](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_repository) | resource |
| [github_branch.branch](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch) | resource |
| [github_branch_default.branch_default](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_default) | resource |
| [time_offset.offset](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/offset) | resource |
| [github_repository_milestone.repository_milestone](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_milestone) | resource |
| [github_issue_label.issue_label](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue_label) | resource |
| [github_issue.issue](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_repository"></a> [repository](#input\_repository) | 'var.repository' is the main variable for github_repository resource settings | <pre>type        = object({<br>  name                                    = string<br>  description                             = optional(string, null)<br>  allow_auto_merge                        = optional(bool, false)<br>  allow_merge_commit                      = optional(bool, true)<br>  allow_rebase_merge                      = optional(bool, true)<br>  allow_squash_merge                      = optional(bool, true)<br>  allow_update_branch                     = optional(bool, false)<br>  archive_on_destroy                      = optional(bool, null)<br>  archived                                = optional(bool, null)<br>  auto_init                               = optional(bool, true)<br>  delete_branch_on_merge                  = optional(bool, false)<br>  gitignore_template                      = optional(string, null)<br>  has_discussions                         = optional(bool, false)<br>  has_downloads                           = optional(bool, false)<br>  has_issues                              = optional(bool, false)<br>  has_projects                            = optional(bool, false)<br>  has_wiki                                = optional(bool, false)<br>  homepage_url                            = optional(string, null)<br>  ignore_vulnerability_alerts_during_read = optional(bool, false)<br>  is_template                             = optional(bool, false)<br>  license_template                        = optional(string, null)<br>  pages                                   = optional(any, null)<br>  security_and_analysis                   = optional(any, null)<br>  template                                = optional(object({<br>    owner                                   = string<br>    repository                              = string<br>    include_all_branches                    = optional(bool, false)<br>  }), null)<br>  topics                                  = optional(list(string), null)<br>  visibility                              = optional(string, null)<br>  vulnerability_alerts                    = optional(bool, null)<br>  web_commit_signoff_required             = optional(bool, false)<br>})<br></pre> | none | yes |
| <a name="input_repository_collaborator"></a> [repository\_collaborator](#input\_repository\_collaborator) | 'var.repository_collaborator' specifies lists of different collaborator types for the repository | <pre>type        = object({<br>  enabled     = optional(bool, true)<br>  admin       = optional(list(string), [])<br>  maintain    = optional(list(string), [])<br>  pull        = optional(list(string), [])<br>  push        = optional(list(string), [])<br>  triage      = optional(list(string), [])<br>})<br></pre> |<pre>{ enabled = false }</pre> | no |
| <a name="input_team_repository"></a> [team\_repository](#input\_team\_repository) | 'var.team_repository' specifies lists of different team names for the repository | <pre>type        = object({<br>  enabled     = optional(bool, true)<br>  admin       = optional(list(string), [])<br>  maintain    = optional(list(string), [])<br>  pull        = optional(list(string), [])<br>  push        = optional(list(string), [])<br>  triage      = optional(list(string), [])<br>})<br></pre> | <pre>{ enabled = false }</pre> | no |
| <a name="input_branch"></a> [branch](#input\_branch) | 'var.branch' is the optional variable for additional github_branch resource settings | <pre>type        = list(object({<br>  branch          = string<br>  source_branch   = optional(string, null)<br>  source_sha      = optional(string, null)<br>}))<br></pre> | <pre>[ ]</pre> | no |
| <a name="input_branch_default"></a> [branch\_default](#input\_branch\_default) | 'var.branch_default' is the optional variable for the github_branch_default resource settings | <pre>type        = object({<br>  branch      = string<br>})<br></pre> | none | no |
| <a name="input_repository_milestone"></a> [repository\_milestone](#input\_repository\_milestone) | 'var.repository_milestone' is the optional variable for the github_repository_milestone resource settings | <pre>type        = map(object({<br>  owner           = string<br>  title           = string<br>  description     = optional(string, null)<br>  due_date        = optional(string, null)<br>  state           = optional(string, "open")<br>}))<br></pre> | <pre>{ }</pre> | no |
| <a name="input_issue_label"></a> [issue\_label](#input\_issue\_label) | 'var.issue_label' is the optional variable for the github_issue_label resource settings | <pre>type        = object({<br>  merge       = optional(bool, null)<br>  label       = optional(list(object({<br>    name        = string<br>    color       = string<br>    description = string<br>  })), [])<br>})<br></pre> | <pre>{ merge = false }</pre> | no |
| <a name="input_issue"></a> [issue](#input\_issue) | 'var.issue' is the optional variable for the github_issue resource settings | <pre>type        = map(object({<br>  title             = string<br>  body              = optional(string, null)<br>  labels            = optional(list(string), [])<br>  assignees         = optional(list(string), [])<br>  milestone_number  = optional(number, null)<br>}))<br></pre> | <pre>{ }</pre> | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_github_repository"></a> [github\_repository](#output\_github\_repository) | list of all exported attributes values from the repository resource(s) |
| <a name="output_github_repository_collaborator"></a> [github\_repository\_collaborator](#output\_github\_repository\_collaborator) | list of all exported attributes values from the repository_collaborator resource(s) |
| <a name="output_github_team_repository"></a> [github\_team\_repository](#output\_github\_team\_repository) | list of all exported attributes values from the team_repository resource(s) |
| <a name="output_github_branch"></a> [github\_branch](#output\_github\_branch) | list of all exported attributes values from the branch resource(s) |
| <a name="output_github_branch_default"></a> [github\_branch\_default](#output\_github\_branch\_default) | list of all exported attributes values from the branch_default resource(s) |
| <a name="output_github_repository_milestone"></a> [github\_repository\_milestone](#output\_github\_repository\_milestone) | list of all exported attributes values from the repository_milestone resource(s) |
| <a name="output_github_issue_label"></a> [github\_issue\_label](#output\_github\_issue\_issue) | list of all exported attributes values from the issue_label resource(s) |
| <a name="output_github_issue"></a> [github\_issue](#output\_github\_issue) | list of all exported attributes values from the issue resource(s) |
  
### Known Issues

Known issues are documented with the GitHub repo's issues functionality. Please filter the issues by **Types** and select **Known Issue** to get the appropriate issues and read the results carefully before using the module to avoid negative impacts on your infrastructure.  
  
<a name="known_issues"></a> [list of Known Issues](https://github.com/uplink-systems/terraform-module-github-repository/issues?q=type%3A%22known%20issue%22)

### Notes / Hints / HowTos

<details>
<summary><b>Lifecycle values</b></summary>

######
* 'repository_milestone' resource -> the module ignores changes of the 'state' attribute because the state should be maintained by the repository's members after initial creation
* 'issue' resource -> the module ignores changes of the 'body' attribute because the issue's body/description should be maintained by the issue's owners after initial creation
######
</details>

<details>
<summary><b>Variable setting 'issue_label.merge'</b></summary>

######
The variable setting 'issue_label.merge' can be used to manage the GitHub's default issue labels in addition to the custom created ones.  
How it works:  
- The default value for the setting is 'false' if no custom issue label is specified to create as this situation implies that issue labels shall not be managed. Setting the value manually to 'true' adds the default GitHub issue labels to Terraform state during next apply and allows them to be managed.  
- The default value for the setting is 'null' if one or more custom issue labels are specified to create. A 'null' value equals a 'true' value for the module and therefore adds the default GitHub issue labels to Terraform state and allows them to be managed. Setting the variable manually to 'false' skips importing the default issue labels.  
The variable setting also allows the admin to REMOVE the GitHub default issue labels. This can be done by setting the value to 'true' and apply. After successfull apply the value must be set to 'false' and applied again. This adds the existing default issue labels to Terraform state during first apply and destroys the issue labels (and removes it from GitHub) during second apply. Changing the variable setting to 'true' again restores the default issue labels again.  
 
######
</details>
