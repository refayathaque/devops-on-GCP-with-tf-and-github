resource "google_bigquery_dataset" "demo_3_dataset" {
  dataset_id = "demo_${var.demo}_dataset"
  # Dataset IDs must be alphanumeric (plus underscores) and must be at most 1024 characters long - No dashes
  description = "De-Identified PII Dataset"
  location    = var.region
}

resource "google_bigquery_table" "demo_3_table" {
  dataset_id = google_bigquery_dataset.demo_3_dataset.dataset_id
  table_id   = "credit_cards"
  schema     = file("bq_schema.json")
}
