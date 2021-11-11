terraform {
  required_providers {
    pagerduty = {
      source  = "pagerduty/pagerduty"
      version = "~> 2.1.1"
    }
  }
}

# Configure the PagerDuty provider
# Set the PAGERDUTY_TOKEN as an environment variable
# provider "pagerduty" {
#   token = var.PAGERDUTY_TOKEN
# }
