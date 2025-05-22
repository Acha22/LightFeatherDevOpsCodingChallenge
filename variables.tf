variable "ami" {
  type = map(string)
  default = {
    "debian"       = "ami-0779caf41f9ba54f0"
  }
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}