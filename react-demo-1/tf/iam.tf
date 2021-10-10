resource "google_service_account" "create_bucket" {
  account_id = "${var.demo}-create-bucket"
}

resource "google_project_iam_custom_role" "create_bucket" {
  role_id     = "create_bucket"
  title       = "Custom Role for create_ microservice"
  permissions = ["storage.buckets.create"]
}

resource "google_service_account" "destroy_buckett" {
  account_id = "${var.demo}-destroy-bucket"
}

resource "google_project_iam_custom_role" "destroy_bucket" {
  role_id     = "destroy_bucket"
  title       = "Custom Role for destroy-bucket microservice"
  permissions = ["storage.buckets.delete"]
}

resource "google_service_account" "update_bucket" {
  account_id = "${var.demo}-update-bucket"
}

resource "google_project_iam_custom_role" "update_bucket" {
  role_id     = "update_bucket"
  title       = "Custom Role for update-bucket microservice"
  permissions = ["storage.buckets.update"]
}

resource "google_service_account" "list_bucket" {
  account_id = "${var.demo}-list-bucket"
}

resource "google_project_iam_custom_role" "list_bucket" {
  role_id     = "list_bucket"
  title       = "Custom Role for list-bucket microservice"
  permissions = ["storage.buckets.get", "storage.buckets.list"]
}

# https://cloud.google.com/iam/docs/permissions-reference
