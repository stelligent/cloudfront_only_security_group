#!/bin/bash -ex

export CLOUDFRONT_ONLY_SECURITY_GROUP_LAMBDA_FUNCTION_NAME=${lambda_function_name}
rspec awspec