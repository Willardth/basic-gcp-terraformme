resource "google_storage_bucket""hihiarm1" {
    name          = "hihiarm1"
    location      = "US"
    storage_class = "STANDARD"
    uniform_bucket_level_access = true
    website {
        main_page_suffix = "index.html"
        not_found_page   = "404.html"
    }
  
}
resource "google_storage_bucket_object" "index-html" {
    name   = "index.html"
    bucket = google_storage_bucket.hihiarm1.name
    source = "index.html"
    
}

resource "google_storage_bucket_iam_binding" "public_read" {
  bucket = google_storage_bucket.hihiarm1.name
  role = "roles/storage.objectViewer"
  members = [
    "allUsers",
  ]
}

output "bucket_url" {
    value = "https://storage.googleapis.com/${google_storage_bucket.hihiarm1.name}/index.html"
}

 
 
 

