variable "dynamodb_map" {
  type = map(object({
    table = object({
      attribute = optional(list(object({
        name = string
        type = string
      })), [])

      hash_key                    = optional(string)
      name                        = string
      billing_mode                = optional(string)
      deletion_protection_enabled = optional(bool)
      region                      = optional(string)

      global_secondary_index = optional(list(object({
        hash_key           = optional(string)
        key_schema         = optional(list(object({ attribute_name = string, key_type = string })), [])
        name               = string
        non_key_attributes = optional(list(string))
        projection_type    = string
        range_key          = optional(string)
        read_capacity      = optional(number)
        on_demand_throughput = optional(object({
          max_read_request_units  = optional(number)
          max_write_request_units = optional(number)
        }))
        warm_throughput = optional(object({
          read_units_per_second  = optional(number)
          write_units_per_second = optional(number)
        }))
        write_capacity = optional(number)
      })), [])

      global_table_witness = optional(object({ region_name = optional(string) }))

      import_table = optional(object({
        input_compression_type = optional(string)
        input_format           = string
        input_format_options = optional(object({
          csv = optional(object({ delimiter = optional(string), header_list = optional(set(string)) }))
        }))
        s3_bucket_source = object({ bucket = string, bucket_owner = optional(string), key_prefix = optional(string) })
      }))

      local_secondary_index = optional(list(object({
        name               = string
        non_key_attributes = optional(list(string))
        projection_type    = string
        range_key          = string
      })), [])

      on_demand_throughput = optional(object({
        max_read_request_units  = optional(number)
        max_write_request_units = optional(number)
      }))

      point_in_time_recovery = optional(object({
        enabled                 = bool
        recovery_period_in_days = optional(number)
      }))

      range_key     = optional(string)
      read_capacity = optional(number)

      replica = optional(list(object({
        consistency_mode            = optional(string)
        deletion_protection_enabled = optional(bool)
        kms_key_arn                 = optional(string)
        point_in_time_recovery      = optional(bool)
        propagate_tags              = optional(bool)
        region_name                 = string
      })), [])

      restore_backup_arn       = optional(string)
      restore_date_time        = optional(string)
      restore_source_name      = optional(string)
      restore_source_table_arn = optional(string)
      restore_to_latest_time   = optional(bool)

      server_side_encryption = optional(object({
        enabled     = bool
        kms_key_arn = optional(string)
      }))

      stream_enabled   = optional(bool)
      stream_view_type = optional(string)
      table_class      = optional(string)

      ttl = optional(object({
        enabled        = optional(bool)
        attribute_name = optional(string)
      }))

      warm_throughput = optional(object({
        read_units_per_second  = optional(number)
        write_units_per_second = optional(number)
      }))

      write_capacity = optional(number)

      timeouts = optional(object({
        create = optional(string)
        update = optional(string)
        delete = optional(string)
      }))

      tags = optional(map(string))
    })

    global_secondary_index_map = optional(map(object({
      index_name = string
      key_schema = list(object({
        attribute_name = string
        attribute_type = string
        key_type       = string
      }))
      on_demand_throughput = optional(object({
        max_read_request_units  = optional(number)
        max_write_request_units = optional(number)
      }))
      projection = optional(object({
        non_key_attributes = optional(set(string))
        projection_type    = string
      }))
      provisioned_throughput = optional(object({
        read_capacity_units  = optional(number)
        write_capacity_units = optional(number)
      }))
      region = optional(string)
      warm_throughput = optional(object({
        read_units_per_second  = optional(number)
        write_units_per_second = optional(number)
      }))
      timeouts = optional(object({
        create = optional(string)
        update = optional(string)
        delete = optional(string)
      }))
    })), {})

    contributor_insights_map = optional(map(object({
      index_name                         = optional(string)
      global_secondary_index_custom_name = optional(string)
      mode                               = optional(string)
      region                             = optional(string)
      timeouts = optional(object({
        create = optional(string)
        delete = optional(string)
      }))
    })), {})

    kinesis_streaming_destination = optional(object({
      approximate_creation_date_time_precision = optional(string)
      region                                   = optional(string)
      stream_arn                               = string
    }))

    table_resource_policy = optional(object({
      policy                              = string
      region                              = optional(string)
      confirm_remove_self_resource_access = optional(bool)
    }))

    stream_resource_policy = optional(object({
      policy                              = string
      region                              = optional(string)
      confirm_remove_self_resource_access = optional(bool)
    }))

    replica_resource_policy_map = optional(map(object({
      policy                              = string
      confirm_remove_self_resource_access = optional(bool)
    })), {})
  }))

  description = "Keyed collection of dynamodb definitions"
}

variable "appautoscaling_map" {
  type = map(object({
    target = optional(object({
      max_capacity       = number
      min_capacity       = number
      resource_id        = string
      scalable_dimension = string
      service_namespace  = string
      role_arn           = optional(string)
      region             = optional(string)
      suspended_state = optional(object({
        dynamic_scaling_in_suspended  = optional(bool)
        dynamic_scaling_out_suspended = optional(bool)
        scheduled_scaling_suspended   = optional(bool)
      }))
      tags = optional(map(string))
    }))

    policies = optional(map(object({
      name               = string
      policy_type        = optional(string)
      resource_id        = optional(string)
      scalable_dimension = optional(string)
      service_namespace  = optional(string)
      region             = optional(string)

      predictive_scaling_policy_configuration = optional(object({
        max_capacity_breach_behavior = optional(string)
        max_capacity_buffer          = optional(number)
        mode                         = optional(string)
        scheduling_buffer_time       = optional(number)
        metric_specification = list(object({
          target_value = number
          customized_capacity_metric_specification = optional(object({
            metric_data_query = list(object({
              expression = optional(string), id = string, label = optional(string), return_data = optional(bool)
              metric_stat = optional(object({
                metric = object({
                  dimension   = optional(set(object({ name = string, value = string })))
                  metric_name = optional(string), namespace = optional(string)
                })
                stat = string, unit = optional(string)
              }))
            }))
          }))
          customized_load_metric_specification = optional(object({
            metric_data_query = list(object({
              expression = optional(string), id = string, label = optional(string), return_data = optional(bool)
              metric_stat = optional(object({
                metric = object({
                  dimension   = optional(set(object({ name = string, value = string })))
                  metric_name = optional(string), namespace = optional(string)
                })
                stat = string, unit = optional(string)
              }))
            }))
          }))
          customized_scaling_metric_specification = optional(object({
            metric_data_query = list(object({
              expression = optional(string), id = string, label = optional(string), return_data = optional(bool)
              metric_stat = optional(object({
                metric = object({
                  dimension   = optional(set(object({ name = string, value = string })))
                  metric_name = optional(string), namespace = optional(string)
                })
                stat = string, unit = optional(string)
              }))
            }))
          }))
          predefined_load_metric_specification    = optional(object({ predefined_metric_type = string, resource_label = optional(string) }))
          predefined_metric_pair_specification    = optional(object({ predefined_metric_type = string, resource_label = optional(string) }))
          predefined_scaling_metric_specification = optional(object({ predefined_metric_type = string, resource_label = optional(string) }))
        }))
      }))

      step_scaling_policy_configuration = optional(object({
        adjustment_type          = optional(string)
        cooldown                 = optional(number)
        metric_aggregation_type  = optional(string)
        min_adjustment_magnitude = optional(number)

        step_adjustment = optional(set(object({
          metric_interval_lower_bound = optional(number)
          metric_interval_upper_bound = optional(number)
          scaling_adjustment          = number
        })))
      }))

      target_tracking_scaling_policy_configuration = optional(object({
        target_value       = number
        disable_scale_in   = optional(bool)
        scale_in_cooldown  = optional(number)
        scale_out_cooldown = optional(number)

        customized_metric_specification = optional(object({
          dimensions = optional(set(object({
            name  = string
            value = string
          })))

          metric_name = optional(string)
          namespace   = optional(string)
          statistic   = optional(string)
          unit        = optional(string)

          metrics = optional(set(object({
            expression = optional(string)
            id         = string
            label      = optional(string)

            metric_stat = optional(object({
              metric = object({
                dimensions = optional(set(object({
                  name  = string
                  value = string
                })))

                metric_name = string
                namespace   = string
              })

              stat = string
              unit = optional(string)
            }))

            return_data = optional(bool)
          })))
        }))

        predefined_metric_specification = optional(object({
          predefined_metric_type = string
          resource_label         = optional(string)
        }))
      }))
    })), {})

    scheduled_actions = optional(map(object({
      name               = string
      resource_id        = optional(string)
      scalable_dimension = optional(string)
      service_namespace  = optional(string)
      region             = optional(string)

      scalable_target_action = object({
        max_capacity = optional(number)
        min_capacity = optional(number)
      })

      schedule   = string
      start_time = optional(string)
      end_time   = optional(string)
      timezone   = optional(string)
    })), {})
  }))

  description = "Keyed collection of appautoscaling definitions. Policies and scheduled actions inherit the target region when resource_id and region are omitted. Terraform continues to manage configured capacity bounds after scheduled actions change them."
  default     = {}
}

variable "dynamodb_autoscaling_map" {
  type = map(object({
    dynamodb_table_custom_name                  = string
    dynamodb_index_name                         = optional(string)
    dynamodb_global_secondary_index_custom_name = optional(string)
    capacity_type                               = string

    target = object({
      max_capacity = number
      min_capacity = number
      role_arn     = optional(string)
      region       = optional(string)
      suspended_state = optional(object({
        dynamic_scaling_in_suspended  = optional(bool)
        dynamic_scaling_out_suspended = optional(bool)
        scheduled_scaling_suspended   = optional(bool)
      }))
      tags = optional(map(string))
    })

    target_tracking = optional(object({
      target_value       = number
      disable_scale_in   = optional(bool)
      scale_in_cooldown  = optional(number)
      scale_out_cooldown = optional(number)
    }))

    scheduled_actions = optional(map(object({
      name = string
      scalable_target_action = object({
        max_capacity = optional(number)
        min_capacity = optional(number)
      })
      schedule   = string
      start_time = optional(string)
      end_time   = optional(string)
      timezone   = optional(string)
    })), {})
  }))

  description = "Keyed DynamoDB table and index autoscaling definitions. dynamodb_index_name takes precedence over dynamodb_global_secondary_index_custom_name. An appautoscaling_map entry with the same key takes precedence. Autoscaled provisioned capacity can cause table or standalone index plan drift because lifecycle ignore_changes cannot be selected dynamically."
  default     = {}
}
