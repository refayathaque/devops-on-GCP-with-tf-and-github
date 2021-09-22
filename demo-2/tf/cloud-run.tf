resource "google_cloud_run_service" "demo_2_service" {
  name     = "demo-2"
  location = "us-east4"
  template {
    spec {
      containers {
        image = "gcr.io/${var.project_id}/demo-2"
      }
    }
  }
  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service_iam_binding" "demo_2_service_binding" {
  location = google_cloud_run_service.demo_2_service.location
  project  = google_cloud_run_service.demo_2_service.project
  service  = google_cloud_run_service.demo_2_service.name
  role     = "roles/run.invoker"
  members = [
    "serviceAccount:${google_service_account.demo_2_service_account.email}"
  ]
}
