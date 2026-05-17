# KMS key for encrypting Secrets Manager secrets
resource "aws_kms_key" "secrets_manager" {
  description             = "KMS key for Secrets Manager encryption"
  deletion_window_in_days = 30
  enable_key_rotation     = true
}

# Create a Secret manager to store the RDS credentials.
resource "aws_secretsmanager_secret" "db_creds" {
  name        = "${var.rds_cluster_name}-rds-creds-2"
  description = "RDS DB credentials"
  kms_key_id  = aws_kms_key.secrets_manager.arn
}

# Set the values of the secrets in the Secret manager
resource "aws_secretsmanager_secret_version" "rds_credentials_version" {
  secret_id     = aws_secretsmanager_secret.db_creds.id
  secret_string = jsonencode({ "username" : var.db_username, "password" : var.db_password })
}
