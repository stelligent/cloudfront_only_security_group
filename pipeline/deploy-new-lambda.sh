#!/bin/bash -elx

region=${AWS_REGION}

bundle install --frozen --system

stack_name=CloudFront-Lambda-Security-Group

sed -i "s/1.0.0-SNAPSHOT/${new_version}/g" cfn/lambda_cfndsl.rb

cfndsl cfn/lambda_cfndsl.rb > output.json

aws cloudformation validate-template --template-body file://output.json \
                                     --region ${region}

lambda_function_name=$(bin/converge_lambda_stack.rb --stack-name ${stack_name} \
                                                    --path output.json)

version_arn=$(aws lambda publish-version --function-name ${lambda_function_name} | jq '.FunctionArn' | tr -d '"')

