# A KeyRing is a toplevel logical grouping of CryptoKeys.
resource "google_kms_key_ring" "demo_3_kms_ring" {
  # count    = local.create_key_ring == true ? 1 : 0
  name     = "demo-${var.demo}-key-ring"
  location = var.region
}

resource "google_kms_crypto_key" "demo_3_kms_key" {
  # count    = google_kms_key_ring.demo_3_kms_ring.count
  name     = "demo-${var.demo}-key"
  key_ring = google_kms_key_ring.demo_3_kms_ring.self_link
}
