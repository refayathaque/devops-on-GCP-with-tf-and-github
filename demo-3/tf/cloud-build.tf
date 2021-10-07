# Need cloud build to create the KEK (key encryption key) - A token encryption key (TEK) is protected (wrapped) with another key (key encryption key) from Cloud Key Management Service (Cloud KMS)

# https://github.com/GoogleCloudPlatform/dlp-dataflow-deidentification/blob/master/dlp-demo-part-1-crypto-key.yaml - but skipping key ring and key creation steps because using tf for those

# resource "google_cloudbuild_trigger" "demo_3_trigger" {
#   name = "demo-${var.demo}-trigger"
#   build {
#     step {
#       name       = "gcr.io/cloud-builders/docker"
#       entrypoint = "bash"
#       # args       = ["-c", "sh create-kek.sh ${_PROJECT_ID} ${_KEY_ID} ${_TEK} ${_KEK} ${_API_KEY}"]
#       args = ["-c", "sh create-kek.sh ${_PROJECT_ID} ${_KEY_ID} ${_TEK} ${_KEK} ${_API_KEY}"]
#     }
#     substitutions = {
#       _PROJECT_ID = var.project
#       _KEY_ID     = google_kms_crypto_key.demo_3_kms_key.id
#       _TEK        = "qux"
#       _KEK        = "qux"
#       _API_KEY    = "qux"
#     }
#   }
# }
