data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

# data "aws_secretsmanager_secret" "tycho_mssql_db" {
#   name = "development/rds-mssql/tycho-db"
# }

# data "aws_secretsmanager_secret_version" "tycho_mssql_db" {
#   secret_id = data.aws_secretsmanager_secret.tycho_mssql_db.id
# }
