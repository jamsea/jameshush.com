terraform {
  required_providers {
    pagerduty = {
      source  = "pagerduty/pagerduty"
      version = "~> 2.1.1"
    }
  }
}

# Configure the PagerDuty provider
provider "pagerduty" {
  token = var.PAGERDUTY_TOKEN
}
