locals {
   get_name = "${var.app_name}-${var.env_name}"
   environment_type = lookup({ prd = "prd", stg = "stg" }, var.env_name, "dev")
   app_environment  = lookup({ prd = "B2B_PF", stg = "staging" }, var.env_name, "development")
}