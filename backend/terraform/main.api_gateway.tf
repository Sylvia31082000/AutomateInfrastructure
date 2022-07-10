module "api_gateway" {
    source          = "./aws_api_gateway"
    name            = local.api_gateway_name  

    data_table      = local.lambda_data_table_arns

    # Stage Deployment
    stage_name      = local.env
    path_to_openapi = local.api_gateway_path_to_openapi

    # API Key / Usage Plan
    api_usage_plan_name  = "${local.api_gateway_name_prefix}-usage-plan"
    api_usage_plan_rate  = 3000
    api_usage_plan_burst = 1500

    cloudwatch_logging_level      = var.api_gateway_cloudwatch_logging_level
    cloudwatch_data_trace_enabled = var.api_gateway_cloudwatch_data_trace_enabled

    # API Settings
    endpoint_configuration_type = local.api_gateway_type

    body = templatefile(
        local.api_gateway_path_to_openapi,
        {            
            # URL
            check_url = module.lambda_check_url.aws_lambda_invoke_arn
            check_email = module.lambda_check_email.aws_lambda_invoke_arn
            
            # ----------------------
            # CORS Integrations
            # ----------------------
            cors_response_access_control_allow_methods = "'POST,GET,OPTIONS'"
            cors_response_access_control_allow_headers = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Ihis-Agent,X-Ihis-Param1,X-Ihis-Param2,X-Ihis-Platform'"
            cors_response_access_control_allow_origin  = "'*'"

            # ----------------------
            # Security Definitions
            # ----------------------
            security_definition = file(var.api_gateway_path_to_openapi_security_definition)
        }
    )
}