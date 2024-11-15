variable "VPC_cidr" {
  description = "cidr da vpc"
  type = string
  default = "10.0.0.0/16"
}

variable "cidrpublica-a" {
  description = "cidr da publica-a"
  type = string
  default = "10.0.2.0/24"
}

variable "cidrpublica-b" {
  description = "cidr da publica-b"
  type = string
  default = "10.0.3.0/24"
}

variable "cidrpublica-c" {
  description = "cidr da publica-c"
  type = string
  default = "10.0.4.0/24"
}


