locals {
  # These users are only in specific environments and will cause the data source to fail if it doesnt exist.
  # The following conditions allow us to toggle the data source based on the enviroment Terraform is running against. 
  # 1 == TRUE; 0 == FALSE
  svc_comlinesauto_tst = (
    var.env == "dev" ? 0 : (
      var.env == "tst" ? 1 : (
        var.env == "qa" ? 1 : (
          var.env == "stg" ? 0 : (
            var.env == "prd" ? 0 : 0
          )
        )
      )
    )
  )
  svc_comlinesauto_qa = (
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
  Automation-Tester = (
    var.env == "dev" ? 0 : (
      var.env == "tst" ? 0 : (
        var.env == "qa" ? 1 : (
          var.env == "stg" ? 0 : (
            var.env == "prd" ? 0 : 0
          )
        )
      )
    )
  )
  Natl-Test = (
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
  Natl-Agent = (
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
  box-sd = (
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
}

# Data Sources for Okta users. 
# Use locals abouve to toggle if the data source should be used for a specific environment. 

data "okta_user" "svc_comlinesauto_tst" {
  count = local.svc_comlinesauto_tst
  search {
    name  = "profile.firstName"
    value = "svc_"
  }

  search {
    name  = "profile.lastName"
    value = "comlinesauto_tst"
  }
}

data "okta_user" "svc_comlinesauto_qa" {
  count = local.svc_comlinesauto_qa
  search {
    name  = "profile.firstName"
    value = "svc_"
  }

  search {
    name  = "profile.lastName"
    value = "comlinesauto_qa"
  }
}

data "okta_user" "Natl-Test" {
  count = local.Natl-Test
  search {
    name  = "profile.firstName"
    value = "Natl"
  }

  search {
    name  = "profile.lastName"
    value = "Test"
  }
}

data "okta_user" "Natl-Agent" {
  count = local.Natl-Agent
  search {
    name  = "profile.firstName"
    value = "Natl"
  }

  search {
    name  = "profile.lastName"
    value = "Agent"
  }
}

data "okta_user" "Automation-Tester" {
  count = local.Automation-Tester
  search {
    name  = "profile.firstName"
    value = "Automation"
  }

  search {
    name  = "profile.lastName"
    value = "Tester"
  }
}

data "okta_user" "box-sd" {
  count = local.box-sd
  search {
    name  = "profile.firstName"
    value = "box"
  }

  search {
    name  = "profile.lastName"
    value = "sd"
  }
}

