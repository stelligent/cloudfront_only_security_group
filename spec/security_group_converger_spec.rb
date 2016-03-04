require 'spec_helper'
require 'security_group_converger'

describe SecurityGroupConverger do
  # context 'security group doesnt exist' do
  #
  #   it 'raises an exception' do
  #
  #     security_group_converger = SecurityGroupConverger.new
  #     expect {
  #       security_group_converger.converge_ingress(sg_id: 'sg-12345678',
  #                                                 ingress_rules: [
  #                                                   {
  #                                                       cidr: '128.0.0.0/20',
  #                                                       port: 80
  #                                                   }
  #                                                 ])
  #     }.to raise_error Aws::EC2::Errors::InvalidGroupNotFound
  #   end
  #
  #   it 'raises an exception' do
  #
  #     security_group_converger = SecurityGroupConverger.new
  #     expect {
  #       security_group_converger.converge_ingress(sg_id: 'sg-fred',
  #                                                 ingress_rules: [
  #                                                     {
  #                                                         cidr: '128.0.0.0/20',
  #                                                         port: 80
  #                                                     }
  #                                                 ])
  #     }.to raise_error Aws::EC2::Errors::InvalidGroupIdMalformed
  #   end
  # end
  #
  # context 'security group exists' do
  #   before(:all) do
  #     @stack_name = stack(stack_name: 'sgupdaterintstack',
  #                         path_to_stack: 'spec/cfndsl_test_templates/basic_security_group_cfndsl.rb',
  #                         bindings: { vpc_id: 'vpc-e382ae86' })
  #     @security_group_converger = SecurityGroupConverger.new
  #   end
  #
  #   context 'an empty array of cidrs' do
  #     it 'makes the security group have no ingress' do
  #
  #       @security_group_converger.converge_ingress(sg_id: stack_outputs['sgId'],
  #                                                  ingress_rules: [])
  #
  #       expect(security_group(stack_outputs['sgId'])).to_not be_opened
  #     end
  #
  #
  #   end
  #
  #   context 'a single cidr on port 80' do
  #     it 'makes the security group have ingress on tcp/80 for that cidr' do
  #       @security_group_converger.converge_ingress(sg_id: stack_outputs['sgId'],
  #                                                  ingress_rules: [
  #                                                     {
  #                                                         cidr: '128.0.0.0/20',
  #                                                         port: 80,
  #                                                         protocol: 'tcp'
  #                                                     }
  #                                                 ])
  #
  #
  #       expect(security_group(stack_outputs['sgId'])).to be_opened(80).
  #                                                        protocol('tcp').
  #                                                        for('128.0.0.0/20')
  #     end
  #
  #
  #   end
  #   after(:all) do
  #     cleanup(@stack_name)
  #   end
  # end


end