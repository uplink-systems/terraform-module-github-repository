####################################################################################################
#   main.tf                                                                                        #
####################################################################################################

##########  Repository section  ####################################################################

resource "github_repository" "repository" {
  name                                    = var.repository.name
  description                             = var.repository.description
  allow_auto_merge                        = var.repository.allow_auto_merge
  allow_merge_commit                      = var.repository.allow_merge_commit
  allow_rebase_merge                      = var.repository.allow_rebase_merge
  allow_squash_merge                      = var.repository.allow_squash_merge
  allow_update_branch                     = var.repository.allow_update_branch
  archive_on_destroy                      = var.repository.archive_on_destroy
  archived                                = var.repository.archived
  auto_init                               = var.repository.auto_init
  delete_branch_on_merge                  = var.repository.delete_branch_on_merge
  gitignore_template                      = var.repository.gitignore_template
  has_discussions                         = var.repository.has_discussions
  has_downloads                           = var.repository.has_downloads
  has_issues                              = var.repository.has_issues
  has_projects                            = var.repository.has_projects
  has_wiki                                = var.repository.has_wiki
  homepage_url                            = var.repository.homepage_url
  ignore_vulnerability_alerts_during_read = var.repository.ignore_vulnerability_alerts_during_read
  is_template                             = var.repository.is_template
  license_template                        = local.repository.visibility == "public" ? (var.repository.license_template == null ? "eupl-1.2" : var.repository.license_template) : var.repository.license_template
  topics                                  = var.repository.topics
  visibility                              = local.repository.visibility
  vulnerability_alerts                    = local.repository.vulnerability_alerts
  web_commit_signoff_required             = var.repository.web_commit_signoff_required
  dynamic "security_and_analysis" {
    for_each    = local.repository.visibility == "public" ? [true] : []
    content {
      dynamic "advanced_security" {
        for_each    = local.repository.security_and_analysis.advanced_security.status != null ? [true] : []
        content {
          status                                  = local.repository.security_and_analysis.advanced_security.status        
        }
      }
      dynamic "secret_scanning" {
        for_each    = local.repository.security_and_analysis.secret_scanning.status != null ? [true] : []
        content {
          status                                  = local.repository.security_and_analysis.secret_scanning.status        
        }
      }
      dynamic "secret_scanning_push_protection" {
        for_each    = local.repository.security_and_analysis.secret_scanning_push_protection.status != null ? [true] : []
        content {
          status                                  = local.repository.security_and_analysis.secret_scanning_push_protection.status        
        }
      }
    }
  }
  dynamic "template" {
    for_each                                = local.repository.template
    content {
      owner                                   = template.value.owner
      repository                              = template.value.repository
      include_all_branches                    = template.value.include_all_branches
    }
  }
  lifecycle {
    ignore_changes  = [ auto_init, license_template, gitignore_template, template ]
  }
}

##########  Repository permissions section  #######################################################

resource "github_repository_collaborator" "repository_collaborator" {
  for_each                                = { for i in concat(local.repository_collaborator.admin,local.repository_collaborator.maintain,local.repository_collaborator.pull,local.repository_collaborator.push,local.repository_collaborator.triage) : i.username => i }
  repository                              = github_repository.repository.name
  username                                = each.value.username
  permission                              = each.value.permission
  depends_on                              = [ github_repository.repository ]
}

resource "github_team_repository" "team_repository" {
  for_each                                = { for i in concat(local.team_repository.admin,local.team_repository.maintain,local.team_repository.pull,local.team_repository.push,local.team_repository.triage) : i.slug => i }
  repository                              = github_repository.repository.name
  team_id                                 = each.value.slug
  permission                              = each.value.permission
  depends_on                              = [ github_repository.repository ]
}

##########  Branch section  #######################################################################

resource "github_branch" "branch" {
  for_each                                = { for b in var.branch : b.branch => b }
  repository                              = github_repository.repository.name
  branch                                  = each.value.branch
  source_branch                           = each.value.source_branch
  source_sha                              = each.value.source_sha
  depends_on                              = [ github_repository.repository ]
}

resource "github_branch_default" "branch_default" {
  repository                              = github_repository.repository.name
  branch                                  = local.branch_default.branch
  depends_on                              = [ github_repository.repository, github_branch.branch ]
}

##########  Milestone section  ####################################################################

resource "time_offset" "offset" {
  for_each                                = { for k, v in var.repository_milestone : k => v if v.due_date == null }
  offset_days                             = 7
}

resource "github_repository_milestone" "repository_milestone" {
  for_each                                = var.repository_milestone
  repository                              = github_repository.repository.name
  title                                   = each.value.title
  owner                                   = each.value.owner
  description                             = each.value.description
  due_date                                = each.value.due_date == null ? formatdate("YYYY-MM-DD", time_offset.offset[each.key].base_rfc3339) : each.value.due_date
  state                                   = each.value.state == null ? "open" : each.value.state
  depends_on                              = [ github_repository.repository, time_offset.offset ]
  lifecycle {
    ignore_changes  = [ state ]
  }
}

##########  Issue section  ########################################################################

resource "github_issue_label" "issue_label" {
  for_each                                = local.issue_label.label
  repository                              = github_repository.repository.name
  name                                    = each.value.name
  color                                   = each.value.color
  description                             = each.value.description
  depends_on                              = [ github_repository.repository ]
}

resource "github_issue" "issue" {
  for_each                                = var.issue
  repository                              = github_repository.repository.name
  title                                   = each.value.title
  body                                    = each.value.body == null ? "## ${each.value.title}" : each.value.body
  labels                                  = each.value.labels
  assignees                               = each.value.assignees
  milestone_number                        = each.value.milestone_number
  depends_on                              = [ github_issue_label.issue_label, github_repository_milestone.repository_milestone ]
  lifecycle {
    ignore_changes  = [ body ]
  }
}
