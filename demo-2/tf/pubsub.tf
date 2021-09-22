resource "google_pubsub_topic" "demo_2_topic" {
  name = "demo-2-topic"
}

output "pubsub-topic-id" {
  value = google_pubsub_topic.demo_2_topic.id
}

resource "google_pubsub_subscription" "demo_2_subscription" {
  name  = "demo-2-subscription"
  topic = google_pubsub_topic.demo_2_topic.name
  push_config {
    push_endpoint = google_cloud_run_service.demo_2_service.status[0].url
    # list/array syntax above from here: https://github.com/mozammal/spring-boot-sample-blog-terraform-sql-gcloud-run/blob/4b5d37de2f2d08eb6030ae50b71231151be5c63f/terraform/spring-boot-blog-terraform-sql-gcloud-run-service.tf
    oidc_token {
      service_account_email = google_service_account.demo_2_service_account.email
    }
    # https://cloud.google.com/pubsub/docs/push#authentication_and_authorization
  }
  dead_letter_policy {
    dead_letter_topic     = google_pubsub_topic.demo_2_topic.id
    max_delivery_attempts = 10
  }
  message_retention_duration = "1200s" # 20 minutes
  expiration_policy {
    ttl = "300000.5s"
  }
  ack_deadline_seconds = 20
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_topic
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_subscription
# pub/sub notifications for Cloud Storage - https://cloud.google.com/storage/docs/pubsub-notifications
