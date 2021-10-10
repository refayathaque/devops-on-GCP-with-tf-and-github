resource "google_cloud_run_service" "create_bucket" {
  name     = "cloudrun-srv"
  location = var.region
  template {
    spec {
      containers {
        image = "us-docker.pkg.dev/cloudrun/container/hello"
      }
    }
  }
  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service_iam_binding" "binding" {
  location = google_cloud_run_service.create_bucket.location
  project  = google_cloud_run_service.create_bucket.project
  service  = google_cloud_run_service.create_bucket.name
  role     = "roles/viewer"
  members = [
    "user:jane@example.com",
  ]
}
