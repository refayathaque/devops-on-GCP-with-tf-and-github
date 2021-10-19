resource "google_project_iam_custom_role" "my-custom-role" {
  role_id     = "myCustomRole"
  title       = "My Custom Role"
  description = "A description"
  permissions = ["resourcemanager.projects.get", "storage.buckets.list", "storage.buckets.get", "storage.objects.list", "storage.objects.get"]
}
