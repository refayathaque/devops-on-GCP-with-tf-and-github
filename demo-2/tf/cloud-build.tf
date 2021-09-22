resource "google_cloudbuild_trigger" "demo_2_trigger" {
  trigger_template {
    branch_name = "master"
    repo_name   = google_sourcerepo_repository.demo_2.name
  }

  filename = "cloudbuild.yaml"
}
