#################################################################################################### 
#   variable.tf                                                                                    # 
####################################################################################################

variable "github" {
  description = <<-EOT
    github provider authentication variable attributes.
    token = personal access token to authenticate with
    owner = context of deployment (either the username or the organisation-name)
  EOT
  type        = object({
    token       = string
    owner       = string
  })
}
