resource "google_pubsub_topic" "inspectbigquerytable" {
  name = "inspectbigquerytable-topic"
}

output "pubsub_topic_id" {
  value = google_pubsub_topic.inspectbigquerytable.id
}

resource "google_pubsub_subscription" "inspectbigquerytable" {
  name  = "inspectbigquerytable-subscription"
  topic = google_pubsub_topic.inspectbigquerytable.name
  # 20 minutes
  message_retention_duration = "1200s"
  retain_acked_messages      = true
  ack_deadline_seconds       = 20
  expiration_policy {
    ttl = "300000.5s"
  }
  retry_policy {
    minimum_backoff = "10s"
  }
  enable_message_ordering = false
}

output "pubsub_subscription_id" {
  value = google_pubsub_subscription.inspectbigquerytable.id
}
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_topic
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_subscription
# pub/sub notifications for Cloud Storage - https://cloud.google.com/storage/docs/pubsub-notifications
