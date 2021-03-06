require_relative 'spec_helper'

describe lambda(ENV['CLOUDFRONT_ONLY_SECURITY_GROUP_LAMBDA_FUNCTION_NAME']) do
  it { should exist }
  its(:handler) { should eq 'JRubyHandlerWrapper::handler' }
  its(:runtime) { should eq 'java8' }
  its(:timeout) { should eq  240 }
  its(:memory_size) { should eq 448 }

  its(:role) {
    should_not eq nil
  }
end