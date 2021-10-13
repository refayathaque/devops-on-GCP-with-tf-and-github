resource "google_service_account" "demo_3_bigquery" {
  account_id = "demo-${var.demo}-bigquery-sa"
}

resource "google_project_iam_custom_role" "demo_3_bigquery_load_job" {
  role_id     = "demo_${var.demo}_bigquery_load_job"
  title       = "Demo ${var.demo} BigQuery Load Job"
  permissions = ["bigquery.tables.create", "bigquery.tables.updateData", "bigquery.jobs.create"]
}
# https://cloud.google.com/bigquery/docs/loading-data-cloud-storage-csv#permissions

resource "google_bigquery_dataset_iam_binding" "demo_3" {
  dataset_id = google_bigquery_dataset.demo_3.dataset_id
  role       = google_project_iam_custom_role.demo_3_bigquery_load_job.id
  members = [
    "serviceAccount:${google_service_account.demo_3_bigquery.email}",
  ]
}

# resource "google_bigquery_table_iam_binding" "demo_3" {
#   dataset_id = google_bigquery_table.demo_3.dataset_id
#   table_id   = google_bigquery_table.demo_3.table_id
#   role       = google_project_iam_custom_role.demo_3_bigquery_load_job.id
#   members = [
#     "serviceAccount:${google_service_account.demo_3_bigquery.email}",
#   ]
# }
