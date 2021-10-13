resource "google_bigquery_dataset" "demo_3" {
  dataset_id = "demo_${var.demo}_dataset"
  # Dataset IDs must be alphanumeric (plus underscores) and must be at most 1024 characters long - No dashes
  location = var.region
}

resource "google_bigquery_table" "demo_3" {
  dataset_id          = google_bigquery_dataset.demo_3.dataset_id
  deletion_protection = false
  schema              = file("bq_schema.json")
  table_id            = "demo_${var.demo}_table"
}

resource "google_bigquery_data_transfer_config" "demo_3" {
  data_source_id         = "google_cloud_storage"
  destination_dataset_id = google_bigquery_dataset.demo_3.dataset_id
  display_name           = "demo-${var.demo}-manual"
  location               = var.region
  params = {
    data_path_template              = "${google_storage_bucket.demo_3.url}/${google_storage_bucket_object.demo_3.output_name}"
    destination_table_name_template = google_bigquery_table.demo_3.table_id
    field_delimiter                 = ","
    file_format                     = "CSV"
    max_bad_records                 = 0
    skip_leading_rows               = 1
    write_disposition               = "APPEND"
  }
  schedule_options {
    disable_auto_scheduling = true
  }
}
# https://github.com/batect/updates.batect.dev/blob/fc5666360296907a18999b0cbf5535ef32ae5419/infra/event_table/transfer.tf
# https://github.com/ashwini2206soni/bigquery_data_transfer/blob/719d0df6679d0d2f1656435a7d16a575aff41143/terraform/main.tf
