resource "google_compute_instance" "helloyou" {
  name         = "toolegit"
  machine_type = "n2-standard-2"
  zone         = "us-central1-a"

 boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
 }
 

 network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }
  




}





