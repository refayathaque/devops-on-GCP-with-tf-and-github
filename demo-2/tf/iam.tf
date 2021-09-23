resource "google_service_account" "demo_2_cloud_run_service_account" {
  account_id = "demo-2-cloud-run-service-acct"
}

# resource "google_service_account" "demo_2_cloud_build_service_account" {
#   account_id = "demo-2-cloud-bild-service-acct"
# }

data "google_service_account" "default_compute_service_account" {
  account_id = "${var.project_number}-compute@developer.gserviceaccount.com"
  # by account_id they mean email
}

resource "google_service_account_iam_binding" "demo_2_admin_account_iam" {
  service_account_id = data.google_service_account.default_compute_service_account.name
  role               = "roles/iam.serviceAccountUser"
  members = [
    # "serviceAccount:${google_service_account.demo_2_cloud_build_service_account.email}"
    "serviceAccount:${var.project_number}@cloudbuild.gserviceaccount.com"
  ]
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account_iam#google_service_account_iam_binding
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/service_account
