# CI/CD for Frontend Using AWS Amplify

Description for how CI/CD works with AWS Amplify and how it is setup for the ds_frontend web app.

AWS Amplify provides git-based workflow for hosting serverless web apps with continuous deployment.Below are the steps for the setup. 

## Pre-Requisites
1. AWS Amplify needs access to the github repository to connect with the web app we will be hosting. To setup navigate to [https://github.com/apps/aws-amplify-eu-west-2](https://github.com/apps/aws-amplify-eu-west-2) and select the repositories you need to connect AWS Amplify to. We have set this up for the `sonamdhingrax/ds_frontend repo`.
2. Also, since we are are using terraform for infrastructure as code we need to create a github personal access token which will be passed to terraform as environment variable.
3. Register at [https://timezonedb.com/register](https://timezonedb.com/register) and get an API Key which will also be used as an environment variable to pass on to terraform.

## Steps
1. In our repository we have created two branches `master` and `rc`. AWS Amplify is configured to build only these branches. The links for viewing the webpages for the branches are at 
	  - [https://simplifycloud.uk/](https://simplifycloud.uk/)
	  - [https://rc.simplifycloud.uk/](https://rc.simplifycloud.uk/)
2. The `terraform` code will create the web hosting app in AWS Amplify. Once the infrastructure is ready. Navigate to the AWS Amplify console and click on build for both master and rc and branches. This is required only for the first time.
3. Amplify uses `AWS CodePipeline` to orchestrate `AWS CodeBuild` and `AWS CodeDeploy`. These are the AWS native DevOps tools for Build, test and Deployment. 
4. From the next time the code will be built and deployed once the code is merged into master or rc branches.
5. As an improvement to the existing codebase, we can add Cypress Tests to check the elements and validate their contents.
