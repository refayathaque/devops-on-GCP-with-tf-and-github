# resource "google_cloudbuild_trigger" "demo_1_trigger" {
#   trigger_template {
#     branch_name = "master"
#     repo_name   = google_sourcerepo_repository.demo_1.name
#   }
#   filename = "cloudbuild.yaml"
# }

# this needs to be changed, look at demo-2, also need to add cloudbuild.yaml in source code root dir
