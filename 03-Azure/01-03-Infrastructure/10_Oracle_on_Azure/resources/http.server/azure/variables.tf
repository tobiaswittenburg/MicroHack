## General VARs
variable "ssh_vm_public_key" {
  type        = string
  description = "Public Key used to access demo Virtual Machines."
  sensitive   = true
}
variable "my_ip" {
  type        = string
  description = "Source Public IP for AWS/Google security groups."
  default     = "1.2.3.4/32"
}

variable "prefix" {
  description = "will be used as default name for resources"
  type        = string
}

variable "location" {
  description = "location where we are going to deploy azure resources"
  type        = string
}

variable "environment_tag" {
  description = "env tag for resources"
  type        = string
  default     = "microsoft.oracle.microhack"
}

variable "vm_admin_username" {
  description = "vm admin user name"
  type        = string
  default     = "chpinoto"
}

