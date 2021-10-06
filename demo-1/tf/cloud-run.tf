resource "google_cloud_run_service" "demo_1" {
  name     = "demo-1"
  location = "us-east4"
  template {
    spec {
      containers {
        image = "gcr.io/wbtg63wxu/hello-world"
        # ^ container image source code can be found in ready-to-containerize dir
      }
    }
  }
  traffic {
    percent         = 100
    latest_revision = true
  }
}
# allow unauthenticated users to invoke the service, i.e., hit the service URL and have it work
data "google_iam_policy" "demo_1_noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}
resource "google_cloud_run_service_iam_policy" "demo_1_noauth" {
  location    = google_cloud_run_service.demo_1.location
  project     = google_cloud_run_service.demo_1.project
  service     = google_cloud_run_service.demo_1.name
  policy_data = data.google_iam_policy.demo_1_noauth.policy_data
}
output "cloud_run_service_url" {
  value = google_cloud_run_service.demo_1.status[0].url
}
