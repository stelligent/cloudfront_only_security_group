#!/bin/bash -ex

export FUNCTION_NAME=${lambda_function_name}
export FUNCTION_VERSION=${new_lambda_version}
rspec spec_end_to_end