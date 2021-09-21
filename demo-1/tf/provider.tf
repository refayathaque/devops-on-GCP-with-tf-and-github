provider "google" {
  project     = "wbtg63wxu"
  region      = "us-east4"
  credentials = "${var.service_account_key_dir}/${var.service_account_key}"
}
