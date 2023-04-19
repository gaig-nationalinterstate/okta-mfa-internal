locals {
  # These groups are only in specific environments and will cause the data source to fail if it doesnt exist.
  # The following conditions allow us to toggle the data source based on the enviroment Terraform is running against. 
  # 1 == TRUE; 0 == FALSE
  Okta_MFA_Voice = (
    var.env == "dev" ? 1 : (
      var.env == "tst" ? 1 : (
        var.env == "qa" ? 1 : (
          var.env == "stg" ? 1 : (
            var.env == "prd" ? 1 : 0
          )
        )
      )
    )
  )
  Domain_Users = (
    var.env == "dev" ? 1 : (
      var.env == "tst" ? 1 : (
        var.env == "qa" ? 1 : (
          var.env == "stg" ? 1 : (
            var.env == "prd" ? 1 : 0
          )
        )
      )
    )
  )
  Copilot_Agents = (
    var.env == "dev" ? 1 : (
      var.env == "tst" ? 1 : (
        var.env == "qa" ? 1 : (
          var.env == "stg" ? 1 : (
            var.env == "prd" ? 1 : 0
          )
        )
      )
    )
  )
  Copilot_Insureds = (
    var.env == "dev" ? 1 : (
      var.env == "tst" ? 0 : (
        var.env == "qa" ? 1 : (
          var.env == "stg" ? 0 : (
            var.env == "prd" ? 1 : 0
          )
        )
      )
    )
  )
  Copilot_Customers = (
    var.env == "dev" ? 0 : (
      var.env == "tst" ? 1 : (
        var.env == "qa" ? 0 : (
          var.env == "stg" ? 1 : (
            var.env == "prd" ? 0 : 0
          )
        )
      )
    )
  )
  Copilot_Users = (
    var.env == "dev" ? 1 : (
      var.env == "tst" ? 1 : (
        var.env == "qa" ? 1 : (
          var.env == "stg" ? 1 : (
            var.env == "prd" ? 1 : 0
          )
        )
      )
    )
  )
  Copilot_Internal = (
    var.env == "dev" ? 1 : (
      var.env == "tst" ? 1 : (
        var.env == "qa" ? 1 : (
          var.env == "stg" ? 1 : (
            var.env == "prd" ? 1 : 0
          )
        )
      )
    )
  )
  Copilot_InternalAdmins = (
    var.env == "dev" ? 1 : (
      var.env == "tst" ? 0 : (
        var.env == "qa" ? 1 : (
          var.env == "stg" ? 0 : (
            var.env == "prd" ? 1 : 0
          )
        )
      )
    )
  )
  Cognos_External = (
    var.env == "dev" ? 0 : (
      var.env == "tst" ? 0 : (
        var.env == "qa" ? 0 : (
          var.env == "stg" ? 0 : (
            var.env == "prd" ? 1 : 0
          )
        )
      )
    )
  )
  Cognos_External_Dev = (
    var.env == "dev" ? 0 : (
      var.env == "tst" ? 0 : (
        var.env == "qa" ? 0 : (
          var.env == "stg" ? 0 : (
            var.env == "prd" ? 1 : 0
          )
        )
      )
    )
  )
  Cognos_External_Lab = (
    var.env == "dev" ? 0 : (
      var.env == "tst" ? 0 : (
        var.env == "qa" ? 0 : (
          var.env == "stg" ? 0 : (
            var.env == "prd" ? 1 : 0
          )
        )
      )
    )
  )
  MFA_Users = (
    var.env == "dev" ? 1 : (
      var.env == "tst" ? 1 : (
        var.env == "qa" ? 1 : (
          var.env == "stg" ? 1 : (
            var.env == "prd" ? 0 : 0
          )
        )
      )
    )
  )
  Quote_Agents = (
    var.env == "dev" ? 1 : (
      var.env == "tst" ? 1 : (
        var.env == "qa" ? 1 : (
          var.env == "stg" ? 1 : (
            var.env == "prd" ? 1 : 0
          )
        )
      )
    )
  )
  Quote_Underwriters = (
    var.env == "dev" ? 0 : (
      var.env == "tst" ? 1 : (
        var.env == "qa" ? 1 : (
          var.env == "stg" ? 1 : (
            var.env == "prd" ? 1 : 0
          )
        )
      )
    )
  )
}

# Each Group data source can be toggled per environment.
# Use the locals above to toggle per environment.

# "Everyone" group exists in all tenants by default
data "okta_group" "Everyone" {
  name = "Everyone"
}

data "okta_group" "Okta_MFA_Voice" {
  count = local.Okta_MFA_Voice
  name  = "Okta_MFA_Voice"
}

data "okta_group" "Domain_Users" {
  count = local.Domain_Users
  name  = "Domain Users"
}

data "okta_group" "Copilot_Agents" {
  count = local.Copilot_Agents
  name  = "Copilot_Agents"
}

data "okta_group" "Copilot_Insureds" {
  count = local.Copilot_Insureds
  name  = "Copilot_Insureds"
}

data "okta_group" "Copilot_Customers" {
  count = local.Copilot_Customers
  name  = "Copilot_Customers"
}

data "okta_group" "Copilot_Users" {
  count = local.Copilot_Users
  name  = "Copilot_Users"
}

data "okta_group" "Copilot_Internal" {
  count = local.Copilot_Internal
  name  = "Copilot_Internal"
}

data "okta_group" "Copilot_InternalAdmins" {
  count = local.Copilot_InternalAdmins
  name  = "Copilot_InternalAdmins"
}

data "okta_group" "Cognos_External" {
  count = local.Cognos_External
  name  = "Cognos_External"
}

data "okta_group" "Cognos_External_Dev" {
  count = local.Cognos_External_Dev
  name  = "Cognos_External_Dev"
}

data "okta_group" "Cognos_External_Lab" {
  count = local.Cognos_External_Lab
  name  = "Cognos_External_Lab"
}

data "okta_group" "MFA_Users" {
  count = local.MFA_Users
  name  = "MFA_Users"
}

data "okta_group" "Quote_Agents" {
  count = local.Quote_Agents
  name  = "Quote_Agents"
}

data "okta_group" "Quote_Underwriters" {
  count = local.Quote_Underwriters
  name  = "Quote_Underwriters"
}

