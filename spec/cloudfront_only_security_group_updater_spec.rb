require 'spec_helper'
require 'cloudfront_only_security_group_updater'

describe CloudfrontOnlySecurityGroupUpdater do

  # context 'security group exists with and without tags' do
  #   before(:all) do
  #     @stack_name = stack(stack_name: 'sgtagdiscoverystack',
  #                         path_to_stack: 'spec/cfndsl_test_templates/sg_with_and_without_tags_cfndsl.rb',
  #                         bindings: { vpc_id: 'vpc-e382ae86' })
  #     @cloudfront_only_sg_updater = CloudfrontOnlySecurityGroupUpdater.new
  #   end
  #
  #   it 'updates the one sg with cf ip ranges' do
  #     mock_fetcher = double('CloudFrontIpRangeFetcher')
  #     expect(mock_fetcher).to receive(:fetch).and_return(%w(128.0.0.0/23 155.55.0.0/16))
  #     expect(@cloudfront_only_sg_updater).to receive(:fetcher) { mock_fetcher }
  #
  #     found_security_groups = @cloudfront_only_sg_updater.update tag_name: 'somethingratherunique'
  #
  #     expect(found_security_groups.count).to be 1
  #     expect(found_security_groups.first).to eq stack_outputs['sgId1']
  #
  #     expect(security_group(stack_outputs['sgId1'])).to be_opened(80).
  #                                                          protocol('tcp').
  #                                                          for('128.0.0.0/23')
  #     expect(security_group(stack_outputs['sgId1'])).to be_opened(80).
  #                                                           protocol('tcp').
  #                                                           for('155.55.0.0/16')
  #     expect(security_group(stack_outputs['sgId1']).inbound_rule_count).to eq 2
  #   end
  #
  #   after(:all) do
  #    cleanup(@stack_name)
  #   end
  # end


end