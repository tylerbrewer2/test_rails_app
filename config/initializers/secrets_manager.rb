# Responsible for pulling data from secrets manager

def set_aws_managed_secrets
  # secret name created in aws secret manager
  secret_name = "tf_rds_password"
  # region name
  region_name = 'us-east-1'

  client = Aws::SecretsManager::Client.new(region: region_name)

  begin
    response = client.get_secret_value(secret_id: secret_name)
  rescue Aws::SecretsManager::Errors::DecryptionFailure => e
    raise
  rescue Aws::SecretsManager::Errors::InternalServiceError => e
    raise
  rescue Aws::SecretsManager::Errors::InvalidParameterException => e
    raise
  rescue Aws::SecretsManager::Errors::InvalidRequestException => e
    raise
  rescue Aws::SecretsManager::Errors::ResourceNotFoundException => e
    raise
  else
    ENV['DATABASE_URL'] = "postgres://postgres_user:#{response.secret_string}@terraform-20230124023517117300000001.ctbsli5wm9bg.us-east-1.rds.amazonaws.com:5432/tf_postgres_database"
  end
end