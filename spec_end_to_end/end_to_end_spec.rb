require 'spec_helper'
require 'aws-sdk'
require 'json'

describe 'lambda invocation of cloudfront_only_security_group' do
  before(:all) do
    fail 'FUNCTION_NAME not defined' unless ENV['FUNCTION_NAME']
    fail 'FUNCTION_VERSION not defined' unless ENV['FUNCTION_VERSION']

    @stack_name = stack(stack_name: 'endtoendteststack',
                        path_to_stack: 'spec_end_to_end/cfndsl_test_templates/sg_cfndsl.rb',
                        bindings: { vpc_id: 'vpc-e382ae86' })
  end

  it 'updates the sg with the tag' do
    Aws.config[:http_read_timeout] = 180
    client = Aws::Lambda::Client.new

    test_input = {
      'tag_name' => 'somethingreallyunique',
      'port' => 3434
    }

    start = Time.now
    invoke_response = client.invoke function_name: ENV['FUNCTION_NAME'],
                                    invocation_type: 'RequestResponse',
                                    payload: JSON.generate(test_input),
                                    qualifier:  ENV['FUNCTION_VERSION']

    endx = Time.now

    puts "time: #{endx-start}"
    expect(invoke_response.status_code).to eq 200

    puts invoke_response
    # don't sweat the list - just make sure 3434 gets opened on something, the list won't be empty
    # if all is well
    expect(security_group(stack_outputs['sgId1'])).to be_inbound_opened(3434)
  end

  after(:all) do
    cleanup(@stack_name)
  end
end