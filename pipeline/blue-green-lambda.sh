#!/bin/bash -exl

bin/switch_lambda_alias.rb --function-name ${lambda_function_name} \
                           --alias PROD \
                           --function-version ${new_lambda_version}

# this is idempotent.  only needs to run first time after
# lambda function passes the smoke test
# more elegant way to do this?
bin/subscribe_to_ipchanges.rb --arn arn:aws:lambda:${AWS_REGION}:${AWS_ACCOUNT_NUMBER}:function:${lambda_function_name}:PROD

# delete the old version?


