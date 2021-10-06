resource "google_api_gateway_api" "demo_4" {
  provider = google-beta
  api_id   = "demo-${var.demo}-api"
}
resource "google_api_gateway_api_config" "demo_4" {
  provider      = google-beta
  api           = google_api_gateway_api.demo_4.api_id
  api_config_id = "demo-1-api-cfg"
  openapi_documents {
    document {
      path     = "spec.yaml"
      contents = filebase64("spec.yaml")
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}
resource "google_api_gateway_gateway" "demo_4" {
  provider   = google-beta
  api_config = google_api_gateway_api_config.demo_4.id
  gateway_id = "demo-${var.demo}-gateway"
}
output "api_gateway_gateway_default_hostname" {
  value = google_api_gateway_gateway.demo_4.default_hostname
}
