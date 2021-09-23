resource "google_cloud_run_service" "demo_2_service" {
  name     = "demo-2"
  location = var.region
  template {
    spec {
      containers {
        image = "gcr.io/${var.project_id}/demo-2:latest"
      }
    }
  }
  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service_iam_binding" "demo_2_service_invoker_binding" {
  location = google_cloud_run_service.demo_2_service.location
  project  = google_cloud_run_service.demo_2_service.project
  service  = google_cloud_run_service.demo_2_service.name
  role     = "roles/run.invoker"
  members = [
    "serviceAccount:${google_service_account.demo_2_cloud_run_service_account.email}"
  ]
}

resource "google_project_iam_binding" "demo_2_cloud_build_project_iam_binding" {
  role = "roles/run.admin"
  members = [
    "serviceAccount:${var.project_number}@cloudbuild.gserviceaccount.com"
  ]
}
# enables the Cloud Run admin role for the default Cloud Build service account - you can verify that this worked by going to the settings page in Cloud Build
# https://stackoverflow.com/questions/61003081/how-to-properly-create-gcp-service-account-with-roles-in-terraform
