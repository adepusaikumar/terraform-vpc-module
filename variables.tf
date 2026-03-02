variable "cidr_block" {
    type = string
    default= "10.0.0.0/16"
}

variable "vpc_final_tags" {
  type = map
  default = {}
}