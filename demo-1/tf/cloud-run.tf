resource "google_cloud_run_service" "demo_1_service" {
  name     = "demo-1"
  location = "us-east4"
  template {
    spec {
      containers {
        # image = "gcr.io/${var.project_id}/demo-1"
        image = "gcr.io/wbtg63wxu/hello-world"
        # ^ spring-boot/hello-world container image in ready-to-containerize dir
      }
    }
  }
  traffic {
    percent         = 100
    latest_revision = true
  }
}

# allow unauthenticated users to invoke the service, i.e., hit the service URL and have it work
# https://demo-1-bi7p4glmnq-uk.a.run.app
data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_service.demo_1_service.location
  project     = google_cloud_run_service.demo_1_service.project
  service     = google_cloud_run_service.demo_1_service.name
  policy_data = data.google_iam_policy.noauth.policy_data
}

resource "google_cloud_run_service_iam_binding" "demo_1_service_binding" {
  location = google_cloud_run_service.demo_1_service.location
  project  = google_cloud_run_service.demo_1_service.project
  service  = google_cloud_run_service.demo_1_service.name
  role     = "roles/run.invoker"
  members = [
    "serviceAccount:${google_service_account.demo_1_service_account.email}"
  ]
}
