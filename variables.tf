variable "lambda_function_name" {}
variable "lambda_function_zip_name" {}
variable "lambda_function_handler" {}
variable "lambda_runtime" {}
variable "timeout" {}
variable "expire_limit" {}
variable "security_group_ids" {}
variable "subnet_ids" {}

variable "lambda_nodejs_layer_arn" {}
variable "sqs_arn" {}
variable "source_executable_file_path" {}
variable "s3_event_name" {

}
variable "tags" {

}

variable "database_passwd" {}
variable "database_user" {}
variable "database_host" {}
variable "database_db" {}
variable "database_port" {}
variable "database_enble_ssl" {}

variable "memory" {}