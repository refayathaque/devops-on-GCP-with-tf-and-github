resource "google_cloudbuild_trigger" "filename-trigger" {
  trigger_template {
    branch_name = "master"
    repo_name   = "my-repo"
  }

  github = {
    owner = "bar"
    name = "qux"
    push {
      branch = "dev"
    }
  }

  filename = "cloudbuild.yaml"
}