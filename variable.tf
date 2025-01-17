####################################################################################################
#   variable.tf                                                                                    #
####################################################################################################

variable "repository" {
  description = "repository settings; at least a 'name' value must be provided."
  type        = object({
    name                                    = string
    description                             = optional(string, null)
    allow_auto_merge                        = optional(bool, false)
    allow_merge_commit                      = optional(bool, true)
    allow_rebase_merge                      = optional(bool, true)
    allow_squash_merge                      = optional(bool, true)
    allow_update_branch                     = optional(bool, false)
    archive_on_destroy                      = optional(bool, null)
    archived                                = optional(bool, null)
    auto_init                               = optional(bool, true)
    delete_branch_on_merge                  = optional(bool, null)
    gitignore_template                      = optional(string, null)
    has_discussions                         = optional(bool, false)
    has_downloads                           = optional(bool, false)
    has_issues                              = optional(bool, false)
    has_projects                            = optional(bool, false)
    has_wiki                                = optional(bool, false)
    homepage_url                            = optional(string, null)
    ignore_vulnerability_alerts_during_read = optional(bool, null)
    is_template                             = optional(bool, false)
    license_template                        = optional(string, null)
    pages                                   = optional(any, null)
    security_and_analysis                   = optional(any, null)
    template                                = optional(object({
      owner                                   = string
      repository                              = string
      include_all_branches                    = optional(bool, false)
    }), null)
    topics                                  = optional(list(string), null)
    visibility                              = optional(string, null)
    vulnerability_alerts                    = optional(bool, null)
    web_commit_signoff_required             = optional(bool, false)
  })
  validation {
    condition     = can(regex("^[a-z0-9.-]+$", var.repository.name))
    error_message = <<-EOF
      Naming convention violation: 'var.repository.name' has an invalid value.
      Only the following characters are allowed for the repository's name: "0-9", "a-z", ".", "-"
    EOF
  }
  validation {
    condition     = lower(var.repository.name) == var.repository.name
    error_message = <<-EOF
      Naming convention violation: 'var.repository.name' has an invalid value.
      Only lowercase letters are allowed for the repository's name.
    EOF
  }
}

variable "collaborator" {
  description = "(Optional) object of lists of collaborators separated by their permission (full/maintain/read-only/read-write/triage)"
  type        = object({
    enabled     = optional(bool, true)
    admin       = optional(list(string), [])
    maintain    = optional(list(string), [])
    pull        = optional(list(string), [])
    push        = optional(list(string), [])
    triage      = optional(list(string), [])
  })
  default     = { enabled = false }
}

variable "team" {
  description = "(Optional) object of lists of team names separated by their permission (full/maintain/read-only/read-write/triage)"
  type        = object({
    enabled     = optional(bool, true)
    admin       = optional(list(string), [])
    maintain    = optional(list(string), [])
    pull        = optional(list(string), [])
    push        = optional(list(string), [])
    triage      = optional(list(string), [])
  })
  default     = { enabled = false }
}

variable "branch" {
  description = "(Optional) list of objects of additional repository branches"
  type        = list(object({
    branch          = string
    source_branch   = optional(string, null)
    source_sha      = optional(string, null)
  }))
  default     = []
  validation {
    condition     = alltrue([for b in var.branch : !contains(["main"], b.branch)])
    error_message = <<-EOF
      Branch naming violation: 'var.branch.branch' has an invalid value.
      The value "main" is not allowed as additional branch name.
    EOF
  }
}

variable "branch_default" {
  description = "(Optional) object of repository's default branch."
  type        = object({
    branch      = string
  })
  default     = null
}

variable "repository_milestone" {
  description = "(Optional) map of objects of repository's milestones"
  type        = map(object({
    owner           = string
    title           = string
    description     = optional(string, null)
    due_date        = optional(string, null)
    state           = optional(string, null)
  }))
  default     = { }
  validation {
    condition     = alltrue([for m in var.repository_milestone : (m.due_date == null ? true : can(regex("[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]", m.due_date)))])
    error_message = <<-EOF
      Value violation: one or more values of 'var.repository_milestone.due_date' are invalid.
      Allowed values are: a date formatted as "YYYY-MM-DD" or null.
    EOF
  }
  validation {
    condition     = alltrue([for m in var.repository_milestone : (m.state == null ? true : contains(["open","closed"], m.state))])
    error_message = <<-EOF
      Value violation: one or more values of 'var.repository_milestone.state' are invalid.
      Allowed values are: "open", "closed" or null.
    EOF
  }
}
