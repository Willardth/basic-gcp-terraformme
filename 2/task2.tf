resource "google_compute_network" "task2task2" {
  name = "newtask2"
  project = "class-5-freedom"
  auto_create_subnetworks = "false"

}

resource "google_compute_subnetwork" "task2task2" {
  name = "newtask2"
  project = "class-5-freedom"
  region = "us-west1"
  network = google_compute_network.task2task2.self_link
  ip_cidr_range = "10.234.1.0/24"
}

resource "google_compute_firewall" "task2task2" {
  name = "newtask2tcp"
  project = "class-5-freedom"
  network = google_compute_network.task2task2.self_link
  allow {
    protocol = "tcp"
    ports = ["80", "22" , "443"]
    
  }



  source_ranges = ["0.0.0.0/0"]

}

resource "google_compute_instance" "task2task2" {
  name = "newtask2vm"
  project = "class-5-freedom"
  zone = "us-west1-a"
  machine_type = "e2-micro"
  
  
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size = "10"
      
      }
      
      
      
     }
      network_interface {
        network = google_compute_network.task2task2.name
        subnetwork = google_compute_subnetwork.task2task2.name
        access_config {
          
        }
      }

      metadata_startup_script = "#Thanks to Remo\n!/bin/bash\n# Update and install Apache2\napt update\napt install -y apache2\n\n# Start and enable Apache2\nsystemctl start apache2\nsystemctl enable apache2\n\n# GCP Metadata server base URL and header\nMETADATA_URL='http://metadata.google.internal/computeMetadata/v1'\nMETADATA_FLAVOR_HEADER='Metadata-Flavor: Google'\n\n# Use curl to fetch instance metadata\nlocal_ipv4=$(curl -H '$${METADATA_FLAVOR_HEADER}' -s '$${METADATA_URL}/instance/network-interfaces/0/ip')\nzone=$$(curl -H '$${METADATA_FLAVOR_HEADER}' -s '$${METADATA_URL}/instance/zone')\nproject_id=$(curl -H '$${METADATA_FLAVOR_HEADER}' -s '$${METADATA_URL}/project/project-id')\nnetwork_tags=$(curl -H '$${METADATA_FLAVOR_HEADER}' -s '$${METADATA_URL}/instance/tags')\n\n# Create a simple HTML page and include instance details\ncat <<EOF > /var/www/html/index.html\n<html><body>\n<h2>Welcome to your custom website.</h2>\n<h3>Created with a direct input startup script!</h3>\n<p><b>Instance Name:</b> $(hostname -f)</p>\n<p><b>Instance Private IP Address: </b> $local_ipv4</p>\n<p><b>Zone: </b> $zone</p>\n<p><b>Project ID:</b> $project_id</p>\n<p><b>Network Tags:</b> $network_tags</p>\n</body></html>\nEOF\n"

}
output "internal_ip" {
  value = google_compute_instance.task2task2.network_interface.0.access_config.0.nat_ip
  
}

output "external_ip" {
  value = google_compute_instance.task2task2.network_interface.0.access_config.0.nat_ip
  
}
 


