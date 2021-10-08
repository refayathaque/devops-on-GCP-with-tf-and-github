resource "google_storage_bucket" "demo_3" {
  name          = "demo-${var.demo}-data-storage-bucket"
  location      = "us-east4"
  force_destroy = true
}

resource "google_storage_bucket_object" "demo_3" {
  name   = "credit-card-sample-data"
  source = "../sample-data/CCRecords_1564602825.csv"
  bucket = google_storage_bucket.demo_3.name
}

output "credit_card_sample_data_self_link" {
  value = google_storage_bucket_object.demo_3.self_link
}

