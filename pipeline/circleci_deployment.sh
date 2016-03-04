#!/bin/bash -exl

source pipeline/store-distro.sh
#new_version set

source pipeline/deploy-new-lambda.sh
#lambda_function_name set
#version_arn set

source run-end-to-end-test.sh

#prod_arn
source pipeline/blue-green-lambda.sh