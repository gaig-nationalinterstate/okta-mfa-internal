resource "okta_factor" "voice" {
  active      = "true"
  provider_id = "okta_call"
}

resource "okta_factor" "verify" {
  active      = "true"
  provider_id = "okta_otp"
}

resource "okta_factor" "sms" {
  active      = "true"
  provider_id = "okta_sms"
}