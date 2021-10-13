resource "google_storage_bucket" "demo_3" {
  name          = "demo-${var.demo}-data-storage-bucket"
  location      = "us-east4"
  force_destroy = true
}

resource "google_storage_bucket_object" "demo_3" {
  name = "CCRecords_1564602825.csv"
  # name should have extension (e.g., csv) appended
  source = "../sample-data/CCRecords_1564602825.csv"
  bucket = google_storage_bucket.demo_3.name
}

output "credit_card_sample_data_bucket_url" {
  value = google_storage_bucket.demo_3.url
}
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket#url

output "credit_card_sample_data_object_output_name" {
  value = google_storage_bucket_object.demo_3.output_name
}
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_object#output_name

