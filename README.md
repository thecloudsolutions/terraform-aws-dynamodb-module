<!-- markdownlint-disable -->
[![Release](https://img.shields.io/github/v/release/thecloudsolutions/terraform-aws-dynamodb-module?style=for-the-badge&color=6150E8)](https://github.com/thecloudsolutions/terraform-aws-dynamodb-module/releases)
[![Commit](https://img.shields.io/github/last-commit/thecloudsolutions/terraform-aws-dynamodb-module?style=for-the-badge&color=FF9800)](https://github.com/thecloudsolutions/terraform-aws-dynamodb-module/commits)
[![Issues](https://img.shields.io/github/issues/thecloudsolutions/terraform-aws-dynamodb-module?style=for-the-badge&color=BB019E)](https://github.com/thecloudsolutions/terraform-aws-dynamodb-module/issues)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-009FD2?style=for-the-badge)](#requirements)
[![License](https://img.shields.io/github/license/thecloudsolutions/terraform-aws-dynamodb-module?style=for-the-badge&color=3FB950)](https://github.com/thecloudsolutions/terraform-aws-dynamodb-module/blob/main/LICENSE)

# terraform-aws-dynamodb-module

[![Cloud Solutions Banner][banner]](https://thecloudsolutions.com/)

[![Sponsor Us](https://img.shields.io/badge/sponsor_us-FF9800?style=for-the-badge)](https://github.com/sponsors/thecloudsolutions)
[![Hire Us](https://img.shields.io/badge/hire_us-009FD2?style=for-the-badge)](https://thecloudsolutions.com/contact-us)
[![Maintained By](https://img.shields.io/badge/maintained_by-Cloud_Solutions-6150E8?style=for-the-badge)](https://thecloudsolutions.com/)

## Description

Terraform module that provisions Amazon DynamoDB tables, secondary indexes, global table replicas, Contributor Insights, and resource-based policies, with support for point-in-time recovery, TTL, encryption, DynamoDB Streams, and streaming destinations for existing Amazon Kinesis data streams. Integrates AWS Application Auto Scaling targets, target tracking policies, and scheduled actions for table and index read/write capacity.

## Variable Naming

In all Cloud Solutions **components** and **modules**, we intentionally use the _map suffix for input variables that accept map(object(...)).

For example:
```hcl
variable "dynamodb_map" {
  type        = map(object({ ... }))
  description = "Keyed collection of dynamodb definitions"
}
```
⚠️ This is a deliberate deviation from [Terraform Style Guide](https://developer.hashicorp.com/terraform/language/syntax/style).

We fully acknowledge that this naming convention does not follow the Terraform style guide, which recommends naming variables based on what they represent, not how they're implemented. We understand this, and want to emphasize:

1. This is a deliberate, informed decision, not an oversight.
2. Our primary goal is clarity and consistency for developers using our modules.
3. The intent is to give users immediate understanding of what kind of structure they're supplying.

### ✅ Why we made this decision (for our components and modules only)

This convention exists only within our components and modules structure. Here's why it works well for us:

1. Instant clarity for users - The _map suffix immediately signals that the variable supports multiple instances, each keyed by name. This avoids confusion around whether a variable is singular or plural.
2. Uniformity across all resources - Instead of struggling with awkward plurals (like kmses, rdses, vpcs, cloudfronts, account_managements) or inconsistent suffixes (_configs, _definitions, etc.), we use one simple, predictable pattern.
3. Avoids naming collisions - The _map suffix never conflicts with native Terraform or AWS resource types.
4. Future-proof for contributors - When contributors see _map, they can safely assume the structure is a map(object(...)) without checking variables.tf.

### 🙌 What this means for contributors

If you're contributing to Cloud Solutions components or modules, please:

1. Use the _map suffix when introducing a new map(object(...)) variable.
2. Follow the naming pattern consistently: rds_map, vpc_map, cloudfront_map, etc.
3. Don't apply this convention to Terraform projects outside components or modules - it's a local convention, not a global best practice.

If you have strong opinions or ideas for evolving this standard, you're welcome to open a discussion.

## Usage

```hcl
module "terraform-aws-dynamodb-module" {
  source = "git::https://github.com/thecloudsolutions/terraform-aws-dynamodb-module.git"
  # Cloud Solutions recommends to pin every module to a specific version
  # ?ref=x.x.x

  # Required variables
  dynamodb_map = {
    key = <value>
  }

  # Optional variables
  appautoscaling_map = {
    key = <value>
  }
  dynamodb_autoscaling_map = {
    key = <value>
  }
}
```

> [!IMPORTANT]
> In our examples we don't pin modules to specific versions to keep the documentation aligned with the latest releases.
> However, for your own projects, we recommend to pin each module to the exact version you're using. This approach helps maintain the stability of your infrastructure.
> Additionally, adopting a structured process for version updates will help prevent unexpected changes.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.15.8 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.60.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dynamodb"></a> [dynamodb](#module\_dynamodb) | git::https://github.com/thecloudsolutions/terraform-aws-dynamodb-component.git | main |
| <a name="module_appautoscaling"></a> [appautoscaling](#module\_appautoscaling) | git::https://github.com/thecloudsolutions/terraform-aws-appautoscaling-component.git | main |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dynamodb_map"></a> [dynamodb\_map](#input\_dynamodb\_map) | Keyed collection of dynamodb definitions | <pre>map(object({<br/>    table = object({<br/>      attribute = optional(list(object({<br/>        name = string<br/>        type = string<br/>      })), [])<br/><br/>      hash_key                    = optional(string)<br/>      name                        = string<br/>      billing_mode                = optional(string)<br/>      deletion_protection_enabled = optional(bool)<br/>      region                      = optional(string)<br/><br/>      global_secondary_index = optional(list(object({<br/>        hash_key           = optional(string)<br/>        key_schema         = optional(list(object({ attribute_name = string, key_type = string })), [])<br/>        name               = string<br/>        non_key_attributes = optional(list(string))<br/>        projection_type    = string<br/>        range_key          = optional(string)<br/>        read_capacity      = optional(number)<br/>        on_demand_throughput = optional(object({<br/>          max_read_request_units  = optional(number)<br/>          max_write_request_units = optional(number)<br/>        }))<br/>        warm_throughput = optional(object({<br/>          read_units_per_second  = optional(number)<br/>          write_units_per_second = optional(number)<br/>        }))<br/>        write_capacity = optional(number)<br/>      })), [])<br/><br/>      global_table_witness = optional(object({ region_name = optional(string) }))<br/><br/>      import_table = optional(object({<br/>        input_compression_type = optional(string)<br/>        input_format           = string<br/>        input_format_options = optional(object({<br/>          csv = optional(object({ delimiter = optional(string), header_list = optional(set(string)) }))<br/>        }))<br/>        s3_bucket_source = object({ bucket = string, bucket_owner = optional(string), key_prefix = optional(string) })<br/>      }))<br/><br/>      local_secondary_index = optional(list(object({<br/>        name               = string<br/>        non_key_attributes = optional(list(string))<br/>        projection_type    = string<br/>        range_key          = string<br/>      })), [])<br/><br/>      on_demand_throughput = optional(object({<br/>        max_read_request_units  = optional(number)<br/>        max_write_request_units = optional(number)<br/>      }))<br/><br/>      point_in_time_recovery = optional(object({<br/>        enabled                 = bool<br/>        recovery_period_in_days = optional(number)<br/>      }))<br/><br/>      range_key     = optional(string)<br/>      read_capacity = optional(number)<br/><br/>      replica = optional(list(object({<br/>        consistency_mode            = optional(string)<br/>        deletion_protection_enabled = optional(bool)<br/>        kms_key_arn                 = optional(string)<br/>        point_in_time_recovery      = optional(bool)<br/>        propagate_tags              = optional(bool)<br/>        region_name                 = string<br/>      })), [])<br/><br/>      restore_backup_arn       = optional(string)<br/>      restore_date_time        = optional(string)<br/>      restore_source_name      = optional(string)<br/>      restore_source_table_arn = optional(string)<br/>      restore_to_latest_time   = optional(bool)<br/><br/>      server_side_encryption = optional(object({<br/>        enabled     = bool<br/>        kms_key_arn = optional(string)<br/>      }))<br/><br/>      stream_enabled   = optional(bool)<br/>      stream_view_type = optional(string)<br/>      table_class      = optional(string)<br/><br/>      ttl = optional(object({<br/>        enabled        = optional(bool)<br/>        attribute_name = optional(string)<br/>      }))<br/><br/>      warm_throughput = optional(object({<br/>        read_units_per_second  = optional(number)<br/>        write_units_per_second = optional(number)<br/>      }))<br/><br/>      write_capacity = optional(number)<br/><br/>      timeouts = optional(object({<br/>        create = optional(string)<br/>        update = optional(string)<br/>        delete = optional(string)<br/>      }))<br/><br/>      tags = optional(map(string))<br/>    })<br/><br/>    global_secondary_index_map = optional(map(object({<br/>      index_name = string<br/>      key_schema = list(object({<br/>        attribute_name = string<br/>        attribute_type = string<br/>        key_type       = string<br/>      }))<br/>      on_demand_throughput = optional(object({<br/>        max_read_request_units  = optional(number)<br/>        max_write_request_units = optional(number)<br/>      }))<br/>      projection = optional(object({<br/>        non_key_attributes = optional(set(string))<br/>        projection_type    = string<br/>      }))<br/>      provisioned_throughput = optional(object({<br/>        read_capacity_units  = optional(number)<br/>        write_capacity_units = optional(number)<br/>      }))<br/>      region = optional(string)<br/>      warm_throughput = optional(object({<br/>        read_units_per_second  = optional(number)<br/>        write_units_per_second = optional(number)<br/>      }))<br/>      timeouts = optional(object({<br/>        create = optional(string)<br/>        update = optional(string)<br/>        delete = optional(string)<br/>      }))<br/>    })), {})<br/><br/>    contributor_insights_map = optional(map(object({<br/>      index_name                         = optional(string)<br/>      global_secondary_index_custom_name = optional(string)<br/>      mode                               = optional(string)<br/>      region                             = optional(string)<br/>      timeouts = optional(object({<br/>        create = optional(string)<br/>        delete = optional(string)<br/>      }))<br/>    })), {})<br/><br/>    kinesis_streaming_destination = optional(object({<br/>      approximate_creation_date_time_precision = optional(string)<br/>      region                                   = optional(string)<br/>      stream_arn                               = string<br/>    }))<br/><br/>    table_resource_policy = optional(object({<br/>      policy                              = string<br/>      region                              = optional(string)<br/>      confirm_remove_self_resource_access = optional(bool)<br/>    }))<br/><br/>    stream_resource_policy = optional(object({<br/>      policy                              = string<br/>      region                              = optional(string)<br/>      confirm_remove_self_resource_access = optional(bool)<br/>    }))<br/><br/>    replica_resource_policy_map = optional(map(object({<br/>      policy                              = string<br/>      confirm_remove_self_resource_access = optional(bool)<br/>    })), {})<br/>  }))</pre> | n/a | yes |
| <a name="input_appautoscaling_map"></a> [appautoscaling\_map](#input\_appautoscaling\_map) | Keyed collection of appautoscaling definitions. Policies and scheduled actions inherit the target region when resource\_id and region are omitted. Terraform continues to manage configured capacity bounds after scheduled actions change them. | <pre>map(object({<br/>    target = optional(object({<br/>      max_capacity       = number<br/>      min_capacity       = number<br/>      resource_id        = string<br/>      scalable_dimension = string<br/>      service_namespace  = string<br/>      role_arn           = optional(string)<br/>      region             = optional(string)<br/>      suspended_state = optional(object({<br/>        dynamic_scaling_in_suspended  = optional(bool)<br/>        dynamic_scaling_out_suspended = optional(bool)<br/>        scheduled_scaling_suspended   = optional(bool)<br/>      }))<br/>      tags = optional(map(string))<br/>    }))<br/><br/>    policies = optional(map(object({<br/>      name               = string<br/>      policy_type        = optional(string)<br/>      resource_id        = optional(string)<br/>      scalable_dimension = optional(string)<br/>      service_namespace  = optional(string)<br/>      region             = optional(string)<br/><br/>      predictive_scaling_policy_configuration = optional(object({<br/>        max_capacity_breach_behavior = optional(string)<br/>        max_capacity_buffer          = optional(number)<br/>        mode                         = optional(string)<br/>        scheduling_buffer_time       = optional(number)<br/>        metric_specification = list(object({<br/>          target_value = number<br/>          customized_capacity_metric_specification = optional(object({<br/>            metric_data_query = list(object({<br/>              expression = optional(string), id = string, label = optional(string), return_data = optional(bool)<br/>              metric_stat = optional(object({<br/>                metric = object({<br/>                  dimension   = optional(set(object({ name = string, value = string })))<br/>                  metric_name = optional(string), namespace = optional(string)<br/>                })<br/>                stat = string, unit = optional(string)<br/>              }))<br/>            }))<br/>          }))<br/>          customized_load_metric_specification = optional(object({<br/>            metric_data_query = list(object({<br/>              expression = optional(string), id = string, label = optional(string), return_data = optional(bool)<br/>              metric_stat = optional(object({<br/>                metric = object({<br/>                  dimension   = optional(set(object({ name = string, value = string })))<br/>                  metric_name = optional(string), namespace = optional(string)<br/>                })<br/>                stat = string, unit = optional(string)<br/>              }))<br/>            }))<br/>          }))<br/>          customized_scaling_metric_specification = optional(object({<br/>            metric_data_query = list(object({<br/>              expression = optional(string), id = string, label = optional(string), return_data = optional(bool)<br/>              metric_stat = optional(object({<br/>                metric = object({<br/>                  dimension   = optional(set(object({ name = string, value = string })))<br/>                  metric_name = optional(string), namespace = optional(string)<br/>                })<br/>                stat = string, unit = optional(string)<br/>              }))<br/>            }))<br/>          }))<br/>          predefined_load_metric_specification    = optional(object({ predefined_metric_type = string, resource_label = optional(string) }))<br/>          predefined_metric_pair_specification    = optional(object({ predefined_metric_type = string, resource_label = optional(string) }))<br/>          predefined_scaling_metric_specification = optional(object({ predefined_metric_type = string, resource_label = optional(string) }))<br/>        }))<br/>      }))<br/><br/>      step_scaling_policy_configuration = optional(object({<br/>        adjustment_type          = optional(string)<br/>        cooldown                 = optional(number)<br/>        metric_aggregation_type  = optional(string)<br/>        min_adjustment_magnitude = optional(number)<br/><br/>        step_adjustment = optional(set(object({<br/>          metric_interval_lower_bound = optional(number)<br/>          metric_interval_upper_bound = optional(number)<br/>          scaling_adjustment          = number<br/>        })))<br/>      }))<br/><br/>      target_tracking_scaling_policy_configuration = optional(object({<br/>        target_value       = number<br/>        disable_scale_in   = optional(bool)<br/>        scale_in_cooldown  = optional(number)<br/>        scale_out_cooldown = optional(number)<br/><br/>        customized_metric_specification = optional(object({<br/>          dimensions = optional(set(object({<br/>            name  = string<br/>            value = string<br/>          })))<br/><br/>          metric_name = optional(string)<br/>          namespace   = optional(string)<br/>          statistic   = optional(string)<br/>          unit        = optional(string)<br/><br/>          metrics = optional(set(object({<br/>            expression = optional(string)<br/>            id         = string<br/>            label      = optional(string)<br/><br/>            metric_stat = optional(object({<br/>              metric = object({<br/>                dimensions = optional(set(object({<br/>                  name  = string<br/>                  value = string<br/>                })))<br/><br/>                metric_name = string<br/>                namespace   = string<br/>              })<br/><br/>              stat = string<br/>              unit = optional(string)<br/>            }))<br/><br/>            return_data = optional(bool)<br/>          })))<br/>        }))<br/><br/>        predefined_metric_specification = optional(object({<br/>          predefined_metric_type = string<br/>          resource_label         = optional(string)<br/>        }))<br/>      }))<br/>    })), {})<br/><br/>    scheduled_actions = optional(map(object({<br/>      name               = string<br/>      resource_id        = optional(string)<br/>      scalable_dimension = optional(string)<br/>      service_namespace  = optional(string)<br/>      region             = optional(string)<br/><br/>      scalable_target_action = object({<br/>        max_capacity = optional(number)<br/>        min_capacity = optional(number)<br/>      })<br/><br/>      schedule   = string<br/>      start_time = optional(string)<br/>      end_time   = optional(string)<br/>      timezone   = optional(string)<br/>    })), {})<br/>  }))</pre> | `{}` | no |
| <a name="input_dynamodb_autoscaling_map"></a> [dynamodb\_autoscaling\_map](#input\_dynamodb\_autoscaling\_map) | Keyed DynamoDB table and index autoscaling definitions. dynamodb\_index\_name takes precedence over dynamodb\_global\_secondary\_index\_custom\_name. An appautoscaling\_map entry with the same key takes precedence. Autoscaled provisioned capacity can cause table or standalone index plan drift because lifecycle ignore\_changes cannot be selected dynamically. | <pre>map(object({<br/>    dynamodb_table_custom_name                  = string<br/>    dynamodb_index_name                         = optional(string)<br/>    dynamodb_global_secondary_index_custom_name = optional(string)<br/>    capacity_type                               = string<br/><br/>    target = object({<br/>      max_capacity = number<br/>      min_capacity = number<br/>      role_arn     = optional(string)<br/>      region       = optional(string)<br/>      suspended_state = optional(object({<br/>        dynamic_scaling_in_suspended  = optional(bool)<br/>        dynamic_scaling_out_suspended = optional(bool)<br/>        scheduled_scaling_suspended   = optional(bool)<br/>      }))<br/>      tags = optional(map(string))<br/>    })<br/><br/>    target_tracking = optional(object({<br/>      target_value       = number<br/>      disable_scale_in   = optional(bool)<br/>      scale_in_cooldown  = optional(number)<br/>      scale_out_cooldown = optional(number)<br/>    }))<br/><br/>    scheduled_actions = optional(map(object({<br/>      name = string<br/>      scalable_target_action = object({<br/>        max_capacity = optional(number)<br/>        min_capacity = optional(number)<br/>      })<br/>      schedule   = string<br/>      start_time = optional(string)<br/>      end_time   = optional(string)<br/>      timezone   = optional(string)<br/>    })), {})<br/>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dynamodb_table_arns"></a> [dynamodb\_table\_arns](#output\_dynamodb\_table\_arns) | ARN of the table |
| <a name="output_dynamodb_table_ids"></a> [dynamodb\_table\_ids](#output\_dynamodb\_table\_ids) | Name of the table |
| <a name="output_dynamodb_table_tags_all"></a> [dynamodb\_table\_tags\_all](#output\_dynamodb\_table\_tags\_all) | Map of tags assigned to the resource, including those inherited from the provider default\_tags configuration block. |
| <a name="output_dynamodb_table_stream_arns"></a> [dynamodb\_table\_stream\_arns](#output\_dynamodb\_table\_stream\_arns) | Table stream ARNs keyed by table. |
| <a name="output_dynamodb_table_stream_labels"></a> [dynamodb\_table\_stream\_labels](#output\_dynamodb\_table\_stream\_labels) | Table stream labels keyed by table. |
| <a name="output_dynamodb_table_replica_arns"></a> [dynamodb\_table\_replica\_arns](#output\_dynamodb\_table\_replica\_arns) | Replica ARNs keyed by table and Region. |
| <a name="output_dynamodb_table_replicas"></a> [dynamodb\_table\_replicas](#output\_dynamodb\_table\_replicas) | Replica attributes keyed by table and Region. |
| <a name="output_dynamodb_table_replica_stream_arns"></a> [dynamodb\_table\_replica\_stream\_arns](#output\_dynamodb\_table\_replica\_stream\_arns) | Replica stream ARNs keyed by table and Region. |
| <a name="output_dynamodb_table_replica_stream_labels"></a> [dynamodb\_table\_replica\_stream\_labels](#output\_dynamodb\_table\_replica\_stream\_labels) | Replica stream labels keyed by table and Region. |
| <a name="output_dynamodb_global_secondary_index_arns"></a> [dynamodb\_global\_secondary\_index\_arns](#output\_dynamodb\_global\_secondary\_index\_arns) | Standalone global secondary index ARNs keyed by table and index. |
| <a name="output_dynamodb_global_secondary_index_names"></a> [dynamodb\_global\_secondary\_index\_names](#output\_dynamodb\_global\_secondary\_index\_names) | Standalone global secondary index names keyed by table and index. |
| <a name="output_dynamodb_global_secondary_index_regions"></a> [dynamodb\_global\_secondary\_index\_regions](#output\_dynamodb\_global\_secondary\_index\_regions) | Standalone global secondary index Regions keyed by table and index. |
| <a name="output_dynamodb_contributor_insights_ids"></a> [dynamodb\_contributor\_insights\_ids](#output\_dynamodb\_contributor\_insights\_ids) | Contributor Insights identifiers keyed by table and configuration. |
| <a name="output_dynamodb_kinesis_streaming_destination_ids"></a> [dynamodb\_kinesis\_streaming\_destination\_ids](#output\_dynamodb\_kinesis\_streaming\_destination\_ids) | Kinesis streaming destination identifiers keyed by table. |
| <a name="output_dynamodb_table_resource_policy_revision_ids"></a> [dynamodb\_table\_resource\_policy\_revision\_ids](#output\_dynamodb\_table\_resource\_policy\_revision\_ids) | Table policy revision IDs keyed by table. |
| <a name="output_dynamodb_stream_resource_policy_revision_ids"></a> [dynamodb\_stream\_resource\_policy\_revision\_ids](#output\_dynamodb\_stream\_resource\_policy\_revision\_ids) | Stream policy revision IDs keyed by table. |
| <a name="output_dynamodb_replica_resource_policy_revision_ids"></a> [dynamodb\_replica\_resource\_policy\_revision\_ids](#output\_dynamodb\_replica\_resource\_policy\_revision\_ids) | Replica policy revision IDs keyed by table and Region. |
| <a name="output_appautoscaling_target_arns"></a> [appautoscaling\_target\_arns](#output\_appautoscaling\_target\_arns) | The ARN of the scalable target. |
| <a name="output_appautoscaling_target_tags_all"></a> [appautoscaling\_target\_tags\_all](#output\_appautoscaling\_target\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider default\_tags configuration block. |
| <a name="output_appautoscaling_target_ids"></a> [appautoscaling\_target\_ids](#output\_appautoscaling\_target\_ids) | Name of the target |
| <a name="output_appautoscaling_target_resource_ids"></a> [appautoscaling\_target\_resource\_ids](#output\_appautoscaling\_target\_resource\_ids) | Name of the resource |
| <a name="output_appautoscaling_target_scalable_dimensions"></a> [appautoscaling\_target\_scalable\_dimensions](#output\_appautoscaling\_target\_scalable\_dimensions) | Scalable dimenison of the target |
| <a name="output_appautoscaling_target_service_namespaces"></a> [appautoscaling\_target\_service\_namespaces](#output\_appautoscaling\_target\_service\_namespaces) | Service namespace of the target |
| <a name="output_appautoscaling_target_suspended_states"></a> [appautoscaling\_target\_suspended\_states](#output\_appautoscaling\_target\_suspended\_states) | Suspended scaling state of the target |
| <a name="output_appautoscaling_policy_alarm_arns"></a> [appautoscaling\_policy\_alarm\_arns](#output\_appautoscaling\_policy\_alarm\_arns) | List of CloudWatch alarm ARNs associated with the scaling policy. |
| <a name="output_appautoscaling_policy_arns"></a> [appautoscaling\_policy\_arns](#output\_appautoscaling\_policy\_arns) | ARN assigned by AWS to the scaling policy. |
| <a name="output_appautoscaling_policy_names"></a> [appautoscaling\_policy\_names](#output\_appautoscaling\_policy\_names) | Scaling policy's name. |
| <a name="output_appautoscaling_policy_types"></a> [appautoscaling\_policy\_types](#output\_appautoscaling\_policy\_types) | Scaling policy's type. |
| <a name="output_appautoscaling_scheduled_action_arns"></a> [appautoscaling\_scheduled\_action\_arns](#output\_appautoscaling\_scheduled\_action\_arns) | The ARN of the scheduled action. |

## Quick Start

The project is under active development, and we welcome all contributors! 🎉
  
Before you start, please review our [Contributor Guidelines](https://github.com/thecloudsolutions/.github/blob/main/CONTRIBUTING.md) to understand the expectations and processes.
  
Follow these steps to get started:
  
---
  
### 1. **Fork the Repository**
- Click the **"Fork"** button on the repository's GitHub page to create a copy under your GitHub account.

> [!TIP]
> If you're new to GitHub, check out the [GitHub Docs](https://docs.github.com/en/get-started) to familiarize yourself with key concepts like forking, branching, and pull requests.
  
### 2. **Clone the Fork**
- Clone your fork to your local machine using:
  ```bash
  git clone https://github.com/<your-username>/<repository-name>.git
  ```
  
### 3. **Create a Branch**
- Create a new branch for your contribution:
  ```bash
  git checkout -b your-feature-name
  ```
  
### 4. **Make Changes**
- Implement your changes in the codebase.
- Ensure you follow the project's style guide and standards.
  
> [!WARNING]
> Always adhere to the project's coding standards and best practices outlined in the [CONTRIBUTING.md](https://github.com/thecloudsolutions/.github/blob/main/CONTRIBUTING.md) file.
    
### 5. **Test Your Changes**
- Run tests to verify your changes locally.
- Follow any project-specific testing instructions.
    
### 6. **Commit Your Changes**
- Stage and commit your changes with a clear and concise message:
  ```bash
  git add .
  git commit -m "Add description of the change"
  ```

> [!NOTE]
> Use meaningful commit messages in the present tense (e.g., "Add feature X" instead of "Added feature X").
  
### 7. **Push Your Branch**
- Push your branch to your fork:
  ```bash
  git push origin your-feature-name
  ```
    
### 8. **Open a Pull Request (PR)**
- Navigate to the original repository and click the **"New Pull Request"** button.
- Select your branch and submit your PR following the [Pull Request template](https://github.com/thecloudsolutions/.github/blob/main/.github/PULL_REQUEST_TEMPLATE/pull_request_template.md).
- Use keywords like `Closes #123` to link your PR to a related issue.
  
### **🎉 Congratulations, you’ve made your first contribution! 🎉**  
We appreciate your effort and look forward to reviewing your work.

## About Us

**Cloud Solutions: Innovating Open Source for AWS & DevOps**

Cloud Solutions creates and maintains free, open-source tools to help startups thrive in the AWS Cloud and DevOps space. Our mission is to make advanced technology accessible to businesses of all sizes.

With years of experience and a commitment to innovation, we design solutions that simplify workflows, encourage collaboration, and drive growth - removing cost barriers along the way. Every contribution brings us closer to a future where technology empowers all.

Your support makes everything we do possible.

Thank you for being part of our journey to empower innovation and build a stronger Open Source future!

## Contributing

The project is under active development, and we welcome all contributors! 🎉 

Before you start, please review our [Contributor Guidelines](CONTRIBUTING.md) to understand the expectations and processes.

## Blog

Link to our [blog](https://thecloudsolutions.com/blog), where you can explore in-depth articles. Gain valuable insights and expert analysis on AWS cloud solution strategies and trends.

## License

The project is 100% Open Source and licensed under the [APACHE2](LICENSE).

## Trademarks

All other trademarks referenced herein are the property of their respective owners.

## Copyrights

Copyright © 2020-2026 [Cloud Solutions](https://thecloudsolutions.com)

[banner]: https://github.com/thecloudsolutions/.github/blob/main/profile/banner.png