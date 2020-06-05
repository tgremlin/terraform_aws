variable "Region" {
  default = ""
}
variable "DNS_Support" {
  default = true
}
variable "DNS_Host_Names" {
  default = true
}
variable "all_ip_cidr" {
  default = "0.0.0.0/0" 
}
variable "Ingress_CIDR_Block" {
  default = ["0.0.0.0/0"]
}
variable "Egress_CIDR_Block" {
  default = ["0.0.0.0/0"]
}
variable "Map_Public_IP" {
  default = true
}
variable "Subnet_cidrs" {
  type    = map(string)
  default = {}
}
variable "vpc_name" {
  description = "Friendly name of VPC"
  type        = string
  default     = ""
}

