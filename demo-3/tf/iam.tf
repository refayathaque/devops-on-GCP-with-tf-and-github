resource "google_service_account" "demo_3_bigquery" {
  account_id = "demo-${var.demo}-bigquery-sa"
}

resource "google_project_iam_custom_role" "demo_3_bigquery" {
  permissions = ["bigquery.transfers.update", "bigquery.datasets.get", "bigquery.datasets.update", "storage.objects.get"]
  role_id     = "demo_${var.demo}_bigquery"
  title       = "Demo ${var.demo} BigQuery"
}
# https://cloud.google.com/bigquery-transfer/docs/cloud-storage-transfer#required_permissions

resource "google_bigquery_dataset_iam_binding" "demo_3" {
  dataset_id = google_bigquery_dataset.demo_3.dataset_id
  members = [
    "serviceAccount:${google_service_account.demo_3_bigquery.email}",
  ]
  role = google_project_iam_custom_role.demo_3_bigquery.id
}
