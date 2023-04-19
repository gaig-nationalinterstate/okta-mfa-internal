locals {
  Copilot = (
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
  Quote-Commercial-Lines = (
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
}

# Use the locals above to toggle if app should be used in specific tenants
data "okta_app" "Copilot" {
  count = local.Copilot
  label = "Copilot"
}

data "okta_app" "Quote-Commercial-Lines" {
  count = local.Quote-Commercial-Lines
  label = "Quote Commercial Lines"
}