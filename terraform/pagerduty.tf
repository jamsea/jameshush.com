
resource "pagerduty_team" "engineering" {
  name = "Engineering"
}

resource "pagerduty_team_membership" "engineering" {
  user_id = pagerduty_user.owner.id
  team_id = pagerduty_team.engineering.id
  role    = "manager"
}

# # pagerduty_schedule.schedule_service_marketing_primary:
resource "pagerduty_schedule" "schedule_service_marketing_primary" {
  name      = "Marketing Primary"
  teams     = [pagerduty_team.engineering.id]
  time_zone = "Asia/Taipei"

  layer {
    name                         = "Layer 1"
    rotation_turn_length_seconds = 604800
    rotation_virtual_start       = "2021-11-11T16:00:00+08:00"
    start                        = "2021-11-11T16:06:03+08:00"
    users = [
      pagerduty_user.owner.id,
      pagerduty_user.example.id,
    ]

    restriction {
      type              = "weekly_restriction"
      start_time_of_day = "08:00:00"
      duration_seconds  = 32400
      start_day_of_week = 1
    }
  }
}

# # pagerduty_service.marketing_pages:
resource "pagerduty_service" "marketing_pages" {
  acknowledgement_timeout = "null"
  alert_creation          = "create_alerts_and_incidents"
  auto_resolve_timeout    = "null"
  description             = <<-EOT
        Your first service - describe what this service is monitoring and any information that will help responders.

        For example: What is the SLA of this service? Where are the runbooks for this service stored? What tier level is this service?
    EOT
  escalation_policy       = pagerduty_escalation_policy.marketing_pages.id
  name                    = "marketing_pages"

  incident_urgency_rule {
    type    = "constant"
    urgency = "high"
  }
}

# Create Escalation policies
resource "pagerduty_escalation_policy" "marketing_pages" {
  name      = "Marketing Pages"
  num_loops = 9
  teams     = [pagerduty_team.engineering.id]
  rule {
    escalation_delay_in_minutes = 30

    target {
      type = "schedule_reference"
      id   = pagerduty_schedule.schedule_service_marketing_primary.id
    }
  }
}


# pagerduty_user.owner:
resource "pagerduty_user" "owner" {
  color     = "purple"
  email     = "hello@jameshush.com"
  name      = "James Hush"
  role      = "owner"
  time_zone = "Asia/Taipei"
  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }
}

resource "pagerduty_user" "example" {
  color     = "red"
  email     = "test@jameshush.com"
  name      = "Testy Test"
  role      = "user"
  time_zone = "Asia/Taipei"
}

resource "pagerduty_user" "example2" {
  color     = "blue"
  email     = "test2@jameshush.com"
  name      = "Testy Test 2"
  role      = "user"
  time_zone = "Asia/Taipei"
}

resource "pagerduty_user" "example3" {
  color     = "blue"
  email     = "test3@jameshush.com"
  name      = "Testy Test 3"
  role      = "user"
  time_zone = "Asia/Taipei"
}

resource "pagerduty_user" "example4" {
  color     = "blue"
  email     = "test3@jameshush.com"
  name      = "Testy Test 3"
  role      = "user"
  time_zone = "Asia/Taipei"
}


data "pagerduty_vendor" "github" {
  name = "Github"
}

resource "pagerduty_service_integration" "github" {
  name    = data.pagerduty_vendor.github.name
  service = pagerduty_service.marketing_pages.id
  vendor  = data.pagerduty_vendor.github.id
}
