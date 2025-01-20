####################################################################################################
#   locals.tf                                                                                      #
####################################################################################################

locals {
  repository      = {
    template                  = var.repository.template == null ? [] : [var.repository.template]
    visibility                = var.repository.visibility == null ? "private" : var.repository.visibility
    security_and_analysis     = {
      advanced_security               = {
        status                          = var.repository.visibility == "public" ? null : try(var.repository.security_and_analysis.advanced_security.status, null)
      }
      secret_scanning                 = {
        status                          = (var.repository.visibility == "public" ? try(var.repository.security_and_analysis.secret_scanning.status, "disabled") : (try(var.repository.security_and_analysis.advanced_security.status == "enabled", false) ? try(var.repository.security_and_analysis.secret_scanning.status, null) : null))
      }
      secret_scanning_push_protection = {
        status                          = (var.repository.visibility == "public" ? try(var.repository.security_and_analysis.secret_scanning_push_protection.status, "disabled") : (try(var.repository.security_and_analysis.advanced_security.status == "enabled", false) ? try(var.repository.security_and_analysis.secret_scanning_push_protection.status, null) : null))
      }
    }
    vulnerability_alerts      = var.repository.visibility == "public" ? (var.repository.vulnerability_alerts == null ? true : var.repository.vulnerability_alerts) : var.repository.vulnerability_alerts
  }
  collaborator    = {
    admin                     = [ for i in var.collaborator.admin : { username = i, permission = "admin" } ]
    maintain                  = [ for i in var.collaborator.maintain : { username = i, permission = "maintain" } ]
    pull                      = [ for i in var.collaborator.pull : { username = i, permission = "pull" } ]
    push                      = [ for i in var.collaborator.push : { username = i, permission = "push" } ]
    triage                    = [ for i in var.collaborator.triage : { username = i, permission = "triage" } ]
  }
  team            = {
    admin                     = [ for i in var.team.admin : { slug = replace(lower(i), "/[^a-z0-9_]/", "-"), permission = "admin" } ]
    maintain                  = [ for i in var.team.maintain : { slug = replace(lower(i), "/[^a-z0-9_]/", "-"), permission = "maintain" } ]
    pull                      = [ for i in var.team.pull : { slug = replace(lower(i), "/[^a-z0-9_]/", "-"), permission = "pull" } ]
    push                      = [ for i in var.team.push : { slug = replace(lower(i), "/[^a-z0-9_]/", "-"), permission = "push" } ]
    triage                    = [ for i in var.team.triage : { slug = replace(lower(i), "/[^a-z0-9_]/", "-"), permission = "triage" } ]
  }
  branch_default  = {
    branch                    = var.branch_default == null ? "main" : var.branch_default.branch
  }
  issue_label     = {
    label                     = merge({ for i in (
      (var.issue_label.merge == null ? true : var.issue_label.merge) ? [
        { name = "bug",              color = "d73a4a", description = "Something isn't working" },
        { name = "documentation",    color = "0075ca", description = "Improvements or additions to documentation" },
        { name = "duplicate",        color = "cfd3d7", description = "This issue or pull request already exists" },
        { name = "enhancement",      color = "a2eeef", description = "New feature or request" },
        { name = "good first issue", color = "7057ff", description = "Good for newcomers" },
        { name = "help wanted",      color = "008672", description = "Extra attention is needed" },
        { name = "invalid",          color = "e4e669", description = "This doesn't seem right" },
        { name = "question",         color = "d876e3", description = "Further information is requested" },
        { name = "wontfix",          color = "ffffff", description = "This will not be worked on" }
      ] : []) : i.name => i }, { for i in var.issue_label.label : lookup(i, "id", lower(i.name)) => merge({description = null}, i) }
    )
  }
}
