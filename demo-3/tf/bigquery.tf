resource "google_bigquery_dataset" "demo_3" {
  dataset_id = "demo_${var.demo}_dataset"
  # Dataset IDs must be alphanumeric (plus underscores) and must be at most 1024 characters long - No dashes
  location = var.region
}

resource "google_bigquery_table" "demo_3" {
  dataset_id          = google_bigquery_dataset.demo_3.dataset_id
  table_id            = "demo_${var.demo}_table"
  schema              = file("bq_schema.json")
  deletion_protection = false
}

resource "google_bigquery_job" "demo_3" {
  # depends_on = [
  #   google_bigquery_dataset.demo_3
  # ]
  job_id = "demo_${var.demo}_bq_load_job"
  load {
    source_uris = [
      google_storage_bucket_object.demo_3.self_link,
    ]
    destination_table {
      project_id = google_bigquery_table.demo_3.project
      dataset_id = google_bigquery_table.demo_3.dataset_id
      table_id   = google_bigquery_table.demo_3.table_id
    }
    skip_leading_rows     = 1
    schema_update_options = ["ALLOW_FIELD_RELAXATION", "ALLOW_FIELD_ADDITION"]
    write_disposition     = "WRITE_APPEND"
    autodetect            = true
  }
}
