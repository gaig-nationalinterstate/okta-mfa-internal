# MFA Policy
resource "okta_policy_mfa" "natl-employees-voice" {
  description     = "Used for employees that have devices that don't support Okta Verify"
  groups_included = [data.okta_group.Okta_MFA_Voice[0].id]
  is_oie          = "false"
  name            = "Multifactor for NATL employees - Voice"

  okta_call = {
    consent_type = "NONE"
    enroll       = "REQUIRED"
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
    enroll       = "NOT_ALLOWED"
  }

  priority = "1"
  status   = "ACTIVE"
}

# Rule
resource "okta_policy_rule_mfa" "mfa-unsupported-employees" {
  enroll             = "CHALLENGE"
  name               = "Multifactor Enrollment for Unsupported Employees"
  network_connection = "ANYWHERE"
  policy_id          = okta_policy_mfa.natl-employees-voice.id
  priority           = "1"
  status             = "ACTIVE"
}