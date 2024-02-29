provider "google" {
  project = var.project_id
  region  = var.location
}

resource "google_healthcare_dicom_store" "default" {
  provider = google-beta

  name    = var.store_id
  dataset = google_healthcare_dataset.dataset.id

  labels = {
    goog-packaged-solution = "medical-imaging-suite"
  }

  stream_configs {
    bigquery_destination {
      table_uri = "bq://${google_bigquery_dataset.bq_dataset.project}.${google_bigquery_dataset.bq_dataset.dataset_id}.${google_bigquery_table.bq_table.table_id}"
    }
  }
}

resource "google_healthcare_dataset" "dataset" {
  name     = var.dataset_id
  location = var.location
}

resource "google_bigquery_dataset" "bq_dataset" {
  dataset_id                 = var.dataset_id
  location                   = var.location
  delete_contents_on_destroy = true
}

resource "google_bigquery_table" "bq_table" {
  labels = {
    goog-packaged-solution = "medical-imaging-suite"
  }

  deletion_protection = false
  dataset_id          = google_bigquery_dataset.bq_dataset.dataset_id
  table_id            = var.table_id
}

resource "google_vertex_ai_endpoint" "default" {
  labels = {
    goog-packaged-solution = "medical-imaging-suite"
  }

  name         = var.vertex_endpoint_name
  display_name = "MedLM Endpoint"
  location     = var.location
}

resource "google_storage_bucket" "default" {
  labels = {
    goog-packaged-solution = "medical-imaging-suite"
  }

  name          = var.gcs_bucket_name
  location      = var.location
  force_destroy = true

  uniform_bucket_level_access = true
}

