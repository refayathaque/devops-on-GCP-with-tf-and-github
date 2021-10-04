resource "google_api_gateway_api" "demo_4_api" {
  provider = google-beta
  api_id   = "demo-${var.demo}-api"
}

output "api_id" {
  value = google_api_gateway_api.demo_4_api.id
}

resource "google_api_gateway_api_config_iam_binding" "binding" {
  api        = google_api_gateway_api_config.demo_4_api.api
  api_config = google_api_gateway_api_config.demo_4_api.api_config_id
  role       = "roles/run.invoker"
  members = [
    "serviceAccount:${google_service_account.demo_4_api_gateway_service_account.email}"
  ]
}

resource "google_api_gateway_api_config" "api_cfg" {
  provider      = google-beta
  api           = google_api_gateway_api.api_cfg.api_id
  api_config_id = "cfg"

  openapi_documents {
    document {
      path     = "spec.yaml"
      contents = filebase64("test-fixtures/apigateway/openapi.yaml")
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}
