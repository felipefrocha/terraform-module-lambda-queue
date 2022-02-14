## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | n/a |
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.iam_for_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_lambda_alias.func](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_alias) | resource |
| [aws_lambda_event_source_mapping.queue_invoke](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_event_source_mapping) | resource |
| [aws_lambda_function.func](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.allow_queue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_sns_topic.topic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [archive_file.lambda](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_database_db"></a> [database\_db](#input\_database\_db) | n/a | `any` | n/a | yes |
| <a name="input_database_enble_ssl"></a> [database\_enble\_ssl](#input\_database\_enble\_ssl) | n/a | `any` | n/a | yes |
| <a name="input_database_host"></a> [database\_host](#input\_database\_host) | n/a | `any` | n/a | yes |
| <a name="input_database_passwd"></a> [database\_passwd](#input\_database\_passwd) | n/a | `any` | n/a | yes |
| <a name="input_database_port"></a> [database\_port](#input\_database\_port) | n/a | `any` | n/a | yes |
| <a name="input_database_user"></a> [database\_user](#input\_database\_user) | n/a | `any` | n/a | yes |
| <a name="input_expire_limit"></a> [expire\_limit](#input\_expire\_limit) | n/a | `any` | n/a | yes |
| <a name="input_lambda_function_handler"></a> [lambda\_function\_handler](#input\_lambda\_function\_handler) | n/a | `any` | n/a | yes |
| <a name="input_lambda_function_name"></a> [lambda\_function\_name](#input\_lambda\_function\_name) | n/a | `any` | n/a | yes |
| <a name="input_lambda_function_zip_name"></a> [lambda\_function\_zip\_name](#input\_lambda\_function\_zip\_name) | n/a | `any` | n/a | yes |
| <a name="input_lambda_nodejs_layer_arn"></a> [lambda\_nodejs\_layer\_arn](#input\_lambda\_nodejs\_layer\_arn) | n/a | `any` | n/a | yes |
| <a name="input_lambda_runtime"></a> [lambda\_runtime](#input\_lambda\_runtime) | n/a | `any` | n/a | yes |
| <a name="input_memory"></a> [memory](#input\_memory) | n/a | `any` | n/a | yes |
| <a name="input_s3_event_name"></a> [s3\_event\_name](#input\_s3\_event\_name) | n/a | `any` | n/a | yes |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | n/a | `any` | n/a | yes |
| <a name="input_source_executable_file_path"></a> [source\_executable\_file\_path](#input\_source\_executable\_file\_path) | n/a | `any` | n/a | yes |
| <a name="input_sqs_arn"></a> [sqs\_arn](#input\_sqs\_arn) | n/a | `any` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | n/a | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `any` | n/a | yes |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | n/a | `any` | n/a | yes |

## Outputs

No outputs.
