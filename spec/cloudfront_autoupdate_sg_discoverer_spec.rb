require 'spec_helper'
require 'cloudfront_autoupdate_sg_discoverer'

describe CloudfrontAutoUpdateDiscoverer do

  context 'security group exists with and without tags' do
    before(:all) do
      @stack_name = stack(stack_name: 'sgtagdiscoverystack',
                          path_to_stack: 'spec/cfndsl_test_templates/sg_with_and_without_tags_cfndsl.rb',
                          bindings: { vpc_id: 'vpc-e382ae86' })
      @cloudfront_autoupdate_sg_discoverer = CloudfrontAutoUpdateDiscoverer.new
    end

    it 'returns the sg with the proper tags' do

      found_security_groups = @cloudfront_autoupdate_sg_discoverer.discover tag_name: 'somethingratherunique'

      expect(found_security_groups.count).to be 1
      expect(found_security_groups.first).to eq stack_outputs['sgId1']
    end

    after(:all) do
      cleanup(@stack_name)
    end
  end


end