# recurso VPC
variable "cidrvpc" {
  description = "CIDR da VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "cidrpublica-a" {
  description = "CIDR da publica a"
  type        = string
  default     = "10.0.2.0/24"
}

variable "cidrpublica-b" {
  description = "CIDR da publica b"
  type        = string
  default     = "10.0.3.0/24"
}

variable "cidrpublica-c" {
  description = "CIDR da publica c"
  type        = string
  default     = "10.0.4.0/24"
}