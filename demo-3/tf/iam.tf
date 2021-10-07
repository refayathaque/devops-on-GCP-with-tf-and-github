resource "google_project_iam_binding" "demo_3_binding_kms_encrypter_for_build" {
  project = var.project
  role    = "roles/cloudkms.cryptoKeyEncrypter"
  members = [
    "serviceAccount:${var.project_number}@cloudbuild.gserviceaccount.com"
  ]
}

resource "google_project_iam_binding" "demo_3_binding_kms_admin_for_build" {
  project = var.project
  role    = "roles/cloudkms.admin"
  members = [
    "serviceAccount:${var.project_number}@cloudbuild.gserviceaccount.com"
  ]
}
