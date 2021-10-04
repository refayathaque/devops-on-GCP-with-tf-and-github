resource "google_storage_bucket" "demo_3_data_storage_bucket" {
  name          = "demo-${var.demo}-data-storage-bucket"
  location      = "us-east4"
  force_destroy = true

}

resource "google_storage_bucket" "demo_3_dataflow_temp_bucket" {
  name          = "demo-${var.demo}-dataflow-temp-bucket"
  location      = "us-east4"
  force_destroy = true
}
# KEK will go here ^
