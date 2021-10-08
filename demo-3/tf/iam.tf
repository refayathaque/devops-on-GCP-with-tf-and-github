resource "google_service_account" "demo_3_bigquery" {
  account_id = "demo-${var.demo}-bigquery-sa"
}

resource "google_bigquery_dataset_iam_binding" "demo_3" {
  dataset_id = google_bigquery_dataset.demo_3.dataset_id
  role       = "roles/storage.objectViewer"
  members = [
    "serviceAccount:${google_service_account.demo_3_bigquery.name}",
  ]
}

resource "google_bigquery_table_iam_binding" "demo_3" {
  project    = google_bigquery_table.demo_3.project
  dataset_id = google_bigquery_table.demo_3.dataset_id
  table_id   = google_bigquery_table.demo_3.table_id
  role       = "roles/storage.objectViewer"
  members = [
    "serviceAccount:${google_service_account.demo_3_bigquery.name}",
  ]
}
