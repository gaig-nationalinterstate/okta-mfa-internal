locals {
    mfa-external-accounts-exclude = (
    var.env == "dev" ? 0 : (
      var.env == "tst" ? 1 : (
        var.env == "qa" ? 1 : (
          var.env == "stg" ? 1 : (
            var.env == "prd" ? 0 : 0
          )
        )
      )
    )
  )
  mfa-external-accounts = (
    var.env == "dev" ? 1 : (
      var.env == "tst" ? 0 : (
        var.env == "qa" ? 0 : (
          var.env == "stg" ? 0 : (
            var.env == "prd" ? 1 : 0
          )
        )
      )
    )
  )
}

# MFA Policy
resource "okta_policy_mfa" "external-accounts" {
  description = "Used for external users accessing Okta Apps. SMS only due to licensing restrictions. See authentication sign on policies for more info."
  groups_included = (
    var.env == "dev" ? [
      data.okta_group.Copilot_Agents[0].id,
      data.okta_group.Copilot_Insureds[0].id,
      data.okta_group.MFA_Users[0].id,
      data.okta_group.Quote_Agents[0].id
      ] : (
      var.env == "tst" ? [
        data.okta_group.Copilot_Agents[0].id,
        data.okta_group.Copilot_Customers[0].id,
        data.okta_group.Copilot_Users[0].id,
        data.okta_group.MFA_Users[0].id,
        data.okta_group.Quote_Agents[0].id
        ] : (
        var.env == "qa" ? [
          data.okta_group.Copilot_Agents[0].id,
          data.okta_group.Copilot_Insureds[0].id,
          data.okta_group.MFA_Users[0].id,
          data.okta_group.Quote_Agents[0].id
          ] : (
          var.env == "stg" ? [
            data.okta_group.Copilot_Agents[0].id,
            data.okta_group.Copilot_Customers[0].id,
            data.okta_group.Copilot_Users[0].id,
            data.okta_group.MFA_Users[0].id,
            data.okta_group.Quote_Agents[0].id
            ] : (
            var.env == "prd" ? [
              data.okta_group.Cognos_External[0].id,
              data.okta_group.Cognos_External_Dev[0].id,
              data.okta_group.Cognos_External_Lab[0].id,
              data.okta_group.Copilot_Agents[0].id,
              data.okta_group.Copilot_Insureds[0].id,
              data.okta_group.Copilot_Users[0].id,
              data.okta_group.Quote_Agents[0].id
            ] : [""]
          )
        )
      )
    )
  )
  is_oie = "false"
  name   = "Multifactor for External Accounts"

  okta_call = {
    consent_type = "NONE"
    enroll       = "NOT_ALLOWED"
  }

  okta_otp = {
    consent_type = "NONE"
    enroll       = "NOT_ALLOWED"
  }

  okta_password = {
    consent_type = "NONE"
    enroll       = "OPTIONAL"
  }

  okta_sms = {
    consent_type = "NONE"
    enroll       = "REQUIRED"
  }

  priority = "3"
  status   = "ACTIVE"
}

# MFA Rules
# MFA rule for external accounts - Exclude users 
resource "okta_policy_rule_mfa" "mfa-external-accounts-user-exclude" {
  count              = local.mfa-external-accounts-exclude
  enroll             = "CHALLENGE"
  name               = "Factor Enrollment Rule"
  network_connection = "ANYWHERE"
  policy_id          = okta_policy_mfa.external-accounts.id
  priority           = "1"
  status             = "ACTIVE"
  users_excluded = (
    var.env == "tst" ? [
      data.okta_user.Natl-Test[0].id,
      data.okta_user.Natl-Agent[0].id
      ] : (
      var.env == "qa" ? [
        data.okta_user.Natl-Test[0].id,
        data.okta_user.Natl-Agent[0].id
        ] : (
        var.env == "stg" ? [
          data.okta_user.Natl-Test[0].id,
          data.okta_user.Natl-Agent[0].id
        ] : [""]
      )
    )
  )
}

# MFA Rule for external accounts - No user exclusions
resource "okta_policy_rule_mfa" "mfa-external-accounts" {
  count              = local.mfa-external-accounts
  enroll             = "CHALLENGE"
  name               = "Factor Enrollment Rule"
  network_connection = "ANYWHERE"
  policy_id          = okta_policy_mfa.external-accounts.id
  priority           = "1"
  status             = "ACTIVE"
}