# MFA Default Policy
resource "okta_policy_mfa_default" "default-policy" {
  is_oie = "false"

  okta_call = {
    consent_type = "NONE"
    enroll       = "NOT_ALLOWED"
  }

  okta_otp = {
    consent_type = "NONE"
    enroll       = "OPTIONAL"
  }

  okta_password = {
    consent_type = "NONE"
    enroll       = "OPTIONAL"
  }

  okta_sms = {
    consent_type = "NONE"
    enroll       = "NOT_ALLOWED"
  }
}

# Default Rule
resource "okta_policy_rule_mfa" "default-rule" {
  enroll             = "CHALLENGE"
  name               = "Default Rule"
  network_connection = "ANYWHERE"
  policy_id          = okta_policy_mfa_default.default-policy.id
  priority           = "1"
  status             = "ACTIVE"
}