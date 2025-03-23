
provider "google" {
  project = "cloud-a3-jaykumar"  
  region  = "us-central1"
}

resource "google_container_cluster" "primary" {
  name     = "my-cluster"
  location = "us-central1-a"
  remove_default_node_pool = true
  initial_node_count = 1
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "my-node-pool"
  cluster    = google_container_cluster.primary.name
  location   = google_container_cluster.primary.location
  node_count = 1

  node_config {
    machine_type = "e2-standard-2"
    disk_size_gb = 20
    disk_type    = "pd-standard"
    image_type   = "cos_containerd"
    preemptible  = false
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}