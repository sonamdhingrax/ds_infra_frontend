# AWS Amplify is the hosting provider 
resource "aws_amplify_app" "timeInformation-app" {
  name                     = "${var.app_name}-frontend"
  repository               = var.frontend_repository
  access_token             = var.github_pat
  enable_branch_auto_build = true
  build_spec               = <<-EOT
    version: 1
    frontend:
      phases:
        preBuild:
          commands:
            - npm ci
        build:
          commands:
            - npm run build
      artifacts:
        baseDirectory: build
        files:
          - '**/*'
      cache:
        paths:
          - node_modules/**/*
  EOT
  # The default rewrites and redirects added by the Amplify Console.
  custom_rule {
    source = "/<*>"
    status = "404"
    target = "/index.html"
  }
  environment_variables = {
    "AMPLIFY_DIFF_DEPLOY"          = "false"
    "REACT_APP_TIMEZONEDB_API_KEY" = var.TIMEZONEDB_API_KEY
  }
}

# Master Branch which is the production version of the Web App with 1 Hour TTL for the cloudfront distribution
resource "aws_amplify_branch" "master" {
  app_id      = aws_amplify_app.timeInformation-app.id
  branch_name = "master"

  framework               = "React"
  enable_performance_mode = true
  ttl                     = 3600
}
# 'rc' branch this is the staging version of the Web App, the default TTL is used which is 5 seconds
resource "aws_amplify_branch" "rc" {
  app_id      = aws_amplify_app.timeInformation-app.id
  branch_name = "rc"
  framework   = "React"
}

resource "aws_amplify_domain_association" "example" {
  app_id      = aws_amplify_app.timeInformation-app.id
  domain_name = var.domain_name

  # Below is the config which associates master branch with simplifycloud.uk
  sub_domain {
    branch_name = aws_amplify_branch.master.branch_name
    prefix      = ""
  }

  # Below is the config which associates master branch with www.simplifycloud.uk
  sub_domain {
    branch_name = aws_amplify_branch.master.branch_name
    prefix      = "www"
  }

  # Below is the config which associates master branch with rc.simplifycloud.uk
  sub_domain {
    branch_name = aws_amplify_branch.rc.branch_name
    prefix      = "rc"
  }


  sub_domain {
    branch_name = aws_amplify_branch.rc.branch_name
    prefix      = "www"
  }
}
