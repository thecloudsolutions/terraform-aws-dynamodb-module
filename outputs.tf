output "dynamodb_table_arns" {
  value       = module.dynamodb.dynamodb_table_arns
  description = "ARN of the table"
}

output "dynamodb_table_ids" {
  value       = module.dynamodb.dynamodb_table_ids
  description = "Name of the table"
}

output "dynamodb_table_tags_all" {
  value       = module.dynamodb.dynamodb_table_tags_all
  description = "Map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
}

output "dynamodb_table_stream_arns" {
  value       = module.dynamodb.dynamodb_table_stream_arns
  description = "Table stream ARNs keyed by table."
}

output "dynamodb_table_stream_labels" {
  value       = module.dynamodb.dynamodb_table_stream_labels
  description = "Table stream labels keyed by table."
}

output "dynamodb_table_replica_arns" {
  value       = module.dynamodb.dynamodb_table_replica_arns
  description = "Replica ARNs keyed by table and Region."
}

output "dynamodb_table_replicas" {
  value       = module.dynamodb.dynamodb_table_replicas
  description = "Replica attributes keyed by table and Region."
}

output "dynamodb_table_replica_stream_arns" {
  value       = module.dynamodb.dynamodb_table_replica_stream_arns
  description = "Replica stream ARNs keyed by table and Region."
}

output "dynamodb_table_replica_stream_labels" {
  value       = module.dynamodb.dynamodb_table_replica_stream_labels
  description = "Replica stream labels keyed by table and Region."
}

output "dynamodb_global_secondary_index_arns" {
  value       = module.dynamodb.dynamodb_global_secondary_index_arns
  description = "Standalone global secondary index ARNs keyed by table and index."
}

output "dynamodb_global_secondary_index_names" {
  value       = module.dynamodb.dynamodb_global_secondary_index_names
  description = "Standalone global secondary index names keyed by table and index."
}

output "dynamodb_global_secondary_index_regions" {
  value       = module.dynamodb.dynamodb_global_secondary_index_regions
  description = "Standalone global secondary index Regions keyed by table and index."
}

output "dynamodb_contributor_insights_ids" {
  value       = module.dynamodb.dynamodb_contributor_insights_ids
  description = "Contributor Insights identifiers keyed by table and configuration."
}

output "dynamodb_kinesis_streaming_destination_ids" {
  value       = module.dynamodb.dynamodb_kinesis_streaming_destination_ids
  description = "Kinesis streaming destination identifiers keyed by table."
}

output "dynamodb_table_resource_policy_revision_ids" {
  value       = module.dynamodb.dynamodb_table_resource_policy_revision_ids
  description = "Table policy revision IDs keyed by table."
}

output "dynamodb_stream_resource_policy_revision_ids" {
  value       = module.dynamodb.dynamodb_stream_resource_policy_revision_ids
  description = "Stream policy revision IDs keyed by table."
}

output "dynamodb_replica_resource_policy_revision_ids" {
  value       = module.dynamodb.dynamodb_replica_resource_policy_revision_ids
  description = "Replica policy revision IDs keyed by table and Region."
}

output "appautoscaling_target_arns" {
  value       = module.appautoscaling.appautoscaling_target_arns
  description = "The ARN of the scalable target."
}

output "appautoscaling_target_tags_all" {
  value       = module.appautoscaling.appautoscaling_target_tags_all
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
}

output "appautoscaling_target_ids" {
  value       = module.appautoscaling.appautoscaling_target_ids
  description = "Name of the target"
}

output "appautoscaling_target_resource_ids" {
  value       = module.appautoscaling.appautoscaling_target_resource_ids
  description = "Name of the resource"
}

output "appautoscaling_target_scalable_dimensions" {
  value       = module.appautoscaling.appautoscaling_target_scalable_dimensions
  description = "Scalable dimenison of the target"
}

output "appautoscaling_target_service_namespaces" {
  value       = module.appautoscaling.appautoscaling_target_service_namespaces
  description = "Service namespace of the target"
}

output "appautoscaling_target_suspended_states" {
  value       = module.appautoscaling.appautoscaling_target_suspended_states
  description = "Suspended scaling state of the target"
}

output "appautoscaling_policy_alarm_arns" {
  value       = module.appautoscaling.appautoscaling_policy_alarm_arns
  description = "List of CloudWatch alarm ARNs associated with the scaling policy."
}

output "appautoscaling_policy_arns" {
  value       = module.appautoscaling.appautoscaling_policy_arns
  description = "ARN assigned by AWS to the scaling policy."
}

output "appautoscaling_policy_names" {
  value       = module.appautoscaling.appautoscaling_policy_names
  description = "Scaling policy's name."
}

output "appautoscaling_policy_types" {
  value       = module.appautoscaling.appautoscaling_policy_types
  description = "Scaling policy's type."
}

output "appautoscaling_scheduled_action_arns" {
  value       = module.appautoscaling.appautoscaling_scheduled_action_arns
  description = "The ARN of the scheduled action."
}
