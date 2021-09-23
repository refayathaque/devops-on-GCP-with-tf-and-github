resource "google_cloudbuild_trigger" "demo_2_trigger" {
  name           = "demo-2-trigger"
  included_files = ["${var.app_dir}/**"]
  # only trigger this pipeline when code changes within this dir in the repo
  filename = "${var.app_dir}/cloudbuild.yaml"
  trigger_template {
    branch_name = "master"
    repo_name   = var.repo_name
    dir         = var.app_dir # run build within this dir
  }
}
