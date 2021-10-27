variable "single_value" {
  default = "sandeep"
}

variable "list" {
  default = ["live", "online"]
}

variable "maps" {
  default = {
    Training = "Terraform"
    trainer =  "Raghu"
    Course = " Devops"
  }
}

output "default" {
  value = var.single_value
}

output "list" {
  value = var.list[0]
}

output "maps" {
  value = var.maps.Course
}
output "statement" {
  value = "${var.single_value} is attending ${var.list[1]} ${var.maps.Training} from ${var.maps.trainer}"
}