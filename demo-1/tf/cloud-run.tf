resource "google_cloud_run_service" "hello_world_service" {
  name     = "${random_string.generator.result}-cloud-run-service-pubsub-java-spring"
  location = "us-east4"
  template {
    spec {
      containers {
        image = "gcr.io/${var.project_id}/demo-1"
      }
    }
  }
  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service_iam_binding" "binding" {
  location = google_cloud_run_service.hello_world_service.location
  project  = google_cloud_run_service.hello_world_service.project
  service  = google_cloud_run_service.hello_world_service.name
  role     = "roles/run.invoker"
  members = [
    "serviceAccount:${google_service_account.hello_world_service_account.email}"
  ]
}
