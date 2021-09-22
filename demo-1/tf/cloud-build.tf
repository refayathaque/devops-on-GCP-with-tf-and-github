resource "google_cloudbuild_trigger" "hello_world_trigger" {
  trigger_template {
    branch_name = "master"
    repo_name   = google_sourcerepo_repository.demo_1.name
  }

  filename = "cloudbuild.yaml"
}
