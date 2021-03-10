variable "cluster_name" {
  description = "key_name of lt conf"
  type        = string
  default = "homework-2"
}

variable "env" {
  description = "environment variable"
  type        = string
  default     = "dev"
}

variable "rgloc" {
  description = "environment variable"
  type        = string
  default     = "eastus2"
}

variable "rgname" {
  description = "environment variable"
  type        = string
  default     = "dev"
}

variable "vm_size" {
  description = "environment variable"
  type        = string
  default     = "Standard_D2_v2"
}

