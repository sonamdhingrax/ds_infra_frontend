# The region from where the amplify web hosting app will be deployed to
variable "region" {
  default = "eu-west-2"
}

# The account to which the web app is deployed to
variable "account_id" {
  default = "406883836544"
}

# Name of the web-application goes here
variable "app_name" {
  default = "timeInformation"
}

# The path for the frontend repository that will be connected to AWS Amplify 
# to create the git-based workflow.
variable "frontend_repository" {
  default = "https://github.com/sonamdhingrax/ds_frontend"
}

# This is a placeholder for github personal access token. The value should be provided as an environment variable
# DO NOT PROVIDE A VALUE
variable "github_pat" {
  description = "GitHub personal access token"
}

# This is a placeholder for TIMEZONEDB API Key. The value should be provided as an environment variable
# DO NOT PROVIDE A VALUE
variable "TIMEZONEDB_API_KEY" {
  description = "API Key for TIMEZONEDB"
}

# The domain stated here should have already been confgured in Route53
variable "domain_name" {
  default = "simplifycloud.uk"
}
