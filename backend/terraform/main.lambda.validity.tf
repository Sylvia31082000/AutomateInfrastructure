
module "lambda_check_url" {
    source = "./aws_lambda"
    name = "checkUrl"
    file_path = "../src/functions/Validity/checkUrl"

    data_table = local.lambda_data_table_arns
    env_vars = {
        ENV                         = local.lambda_env
        METHOD                      = "validity/checkUrl"
    }
}


module "lambda_check_email" {
    source = "./aws_lambda"
    name = "checkEmail"
    file_path = "../src/functions/Validity/checkEmail"

    data_table = local.lambda_data_table_arns
    env_vars = {
        ENV                         = local.lambda_env
        METHOD                      = "validity/checkEmail"
    }
}