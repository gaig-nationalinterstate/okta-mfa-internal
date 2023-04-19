locals {
    # Toggle which rule should be used per tenant
    
    # This rule includes user exclusions
    mfa-all-employees-exclude = (
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

  # This rule Does not contain any user exclusions
  mfa-all-employees = (
    var.env == "dev" ? 1 : (
      var.env == "tst" ? 0 : (
        var.env == "qa" ? 0 : (
          var.env == "stg" ? 0 : (
            var.env == "prd" ? 0 : 0
          )
        )
      )
    )
  )
}

# MFA Policy
resource "okta_policy_mfa" "natl-employees" {
  description     = "Enables multifactor for all NATL employees"
  groups_included = [data.okta_group.Domain_Users[0].id]
  is_oie          = "false"
  name            = "Multifactor for NATL employees"

  okta_call = {
    consent_type = "NONE"
    enroll       = "NOT_ALLOWED"
  }

  okta_otp = {
    consent_type = "NONE"
    enroll       = "REQUIRED"
  }

  okta_password = {
    consent_type = "NONE"
    enroll       = "OPTIONAL"
  }

  okta_sms = {
    consent_type = "NONE"
    enroll       = "NOT_ALLOWED"
  }

  priority = "2"
  status   = "ACTIVE"
}

# MFA Rule
# MFA for All Employees - Exlcude users
resource "okta_policy_rule_mfa" "mfa-all-employees-exclude" {
  count              = local.mfa-all-employees-exclude
  enroll             = "CHALLENGE"
  name               = "Multifactor Enrollment for All Employees"
  network_connection = "ANYWHERE"
  policy_id          = okta_policy_mfa.natl-employees.id
  priority           = "1"
  status             = "ACTIVE"
  users_excluded = (
    var.env == "tst" ? [
      data.okta_user.svc_comlinesauto_tst[0].id,
      data.okta_user.svc_comlinesauto_qa[0].id
      ] : (
      var.env == "qa" ? [
        data.okta_user.Automation-Tester[0].id,
        data.okta_user.svc_comlinesauto_tst[0].id,
        data.okta_user.svc_comlinesauto_qa[0].id
        ] : (
        var.env == "stg" ? [
          data.okta_user.svc_comlinesauto_qa[0].id
          ] : (
          var.env == "prd" ? [
            data.okta_user.box-sd[0].id
          ] : [""]
        )
      )
    )
  )
}

# MFA for All Employees - No user exclusions
resource "okta_policy_rule_mfa" "mfa-all-employees" {
  count              = local.mfa-all-employees
  enroll             = "CHALLENGE"
  name               = "Multifactor Enrollment for All Employees"
  network_connection = "ANYWHERE"
  policy_id          = okta_policy_mfa.natl-employees.id
  priority           = "1"
  status             = "ACTIVE"
}