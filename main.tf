module "dynamodb" {
  source = "git::https://github.com/thecloudsolutions/terraform-aws-dynamodb-component.git?ref=main"

  dynamodb_map = var.dynamodb_map
}

module "appautoscaling" {
  source = "git::https://github.com/thecloudsolutions/terraform-aws-appautoscaling-component.git?ref=main"

  appautoscaling_map = merge({
    for key, scaling in var.dynamodb_autoscaling_map : key => {
      target = {
        max_capacity       = scaling.target.max_capacity
        min_capacity       = scaling.target.min_capacity
        resource_id        = "table/${module.dynamodb.dynamodb_table_ids[scaling.dynamodb_table_custom_name]}${scaling.dynamodb_index_name != null ? "/index/${scaling.dynamodb_index_name}" : scaling.dynamodb_global_secondary_index_custom_name != null ? "/index/${module.dynamodb.dynamodb_global_secondary_index_names[scaling.dynamodb_table_custom_name][scaling.dynamodb_global_secondary_index_custom_name]}" : ""}"
        scalable_dimension = "dynamodb:${scaling.dynamodb_index_name != null || scaling.dynamodb_global_secondary_index_custom_name != null ? "index" : "table"}:${scaling.capacity_type}CapacityUnits"
        service_namespace  = "dynamodb"
        role_arn           = scaling.target.role_arn
        region             = scaling.target.region != null ? scaling.target.region : scaling.dynamodb_index_name == null && scaling.dynamodb_global_secondary_index_custom_name != null ? module.dynamodb.dynamodb_global_secondary_index_regions[scaling.dynamodb_table_custom_name][scaling.dynamodb_global_secondary_index_custom_name] : var.dynamodb_map[scaling.dynamodb_table_custom_name].table.region
        suspended_state    = scaling.target.suspended_state
        tags               = scaling.target.tags
      }
      policies = scaling.target_tracking != null ? {
        target_tracking = {
          name        = "${key}-target-tracking"
          policy_type = "TargetTrackingScaling"
          region      = scaling.target.region != null ? scaling.target.region : scaling.dynamodb_index_name == null && scaling.dynamodb_global_secondary_index_custom_name != null ? module.dynamodb.dynamodb_global_secondary_index_regions[scaling.dynamodb_table_custom_name][scaling.dynamodb_global_secondary_index_custom_name] : var.dynamodb_map[scaling.dynamodb_table_custom_name].table.region
          target_tracking_scaling_policy_configuration = {
            target_value       = scaling.target_tracking.target_value
            disable_scale_in   = scaling.target_tracking.disable_scale_in
            scale_in_cooldown  = scaling.target_tracking.scale_in_cooldown
            scale_out_cooldown = scaling.target_tracking.scale_out_cooldown
            predefined_metric_specification = {
              predefined_metric_type = "DynamoDB${scaling.capacity_type}CapacityUtilization"
            }
          }
        }
      } : {}
      scheduled_actions = {
        for action_key, action in scaling.scheduled_actions : action_key => merge(action, {
          region = scaling.target.region != null ? scaling.target.region : scaling.dynamodb_index_name == null && scaling.dynamodb_global_secondary_index_custom_name != null ? module.dynamodb.dynamodb_global_secondary_index_regions[scaling.dynamodb_table_custom_name][scaling.dynamodb_global_secondary_index_custom_name] : var.dynamodb_map[scaling.dynamodb_table_custom_name].table.region
        })
      }
    } if !contains(keys(var.appautoscaling_map), key)
  }, var.appautoscaling_map)
}
