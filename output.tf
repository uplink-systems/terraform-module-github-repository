####################################################################################################
#   output.tf                                                                                      #
####################################################################################################

output "github_repository" {
  description = "output the github_repository attributes"
  value       = github_repository.repository
  depends_on  = [ github_repository.repository ]
}

output "github_repository_collaborator" {
  description = "output the github_repository_collaborator attributes"
  value       = github_repository_collaborator.collaborator
  depends_on  = [ github_repository_collaborator.collaborator ]
}

output "github_team_repository" {
  description = "output the github_team_repository attributes"
  value       = github_team_repository.team
  depends_on  = [ github_team_repository.team ]
}

output "github_branch" {
  description = "output the github_branch attributes"
  value       = github_branch.branch
  depends_on  = [ github_branch.branch ]
}

output "github_branch_default" {
  description = "output the github_branch_default attributes"
  value       = github_branch_default.branch_default
  depends_on  = [ github_branch_default.branch_default ]
}

output "github_repository_milestone" {
  description = "output the github_repository_milestone attributes"
  value       = github_repository_milestone.repository_milestone
  depends_on  = [ github_repository_milestone.repository_milestone ]
}

output "github_issue_label" {
  description = "output the github_issue_label attributes"
  value       = github_issue_label.issue_label
  depends_on  = [ github_issue_label.issue_label ]
}

output "github_issue" {
  description = "output the github_issue attributes"
  value       = github_issue.issue
  depends_on  = [ github_issue.issue ]
}
