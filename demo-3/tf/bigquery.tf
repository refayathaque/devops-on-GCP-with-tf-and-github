resource "google_bigquery_dataset" "demo_3" {
  dataset_id = "demo_${var.demo}_dataset"
  # Dataset IDs must be alphanumeric (plus underscores) and must be at most 1024 characters long - No dashes
  location = var.region
}

resource "google_bigquery_table" "demo_3" {
  dataset_id = google_bigquery_dataset.demo_3.dataset_id
  table_id   = "demo_${var.demo}_table"
  schema     = file("bq_schema.json")
  external_data_configuration {
    autodetect    = false
    source_format = "CSV"
    csv_options {
      quote             = ""
      skip_leading_rows = 1
    }
    source_uris = [
      google_storage_bucket_object.demo_3.self_link,
    ]
  }
}
