#!/usr/bin/env ruby
require 'trollop'
require_relative 'lib/cloudformation_converger'
require_relative 'lib/ip_space_changed_subscriber'

opts = Trollop::options do
  opt :stack_name, '', type: :string, required: true
  opt :path, '', type: :string, required: true
end

outputs = CloudformationConverger.new.converge stack_name: opts[:stack_name],
                                               stack_path: opts[:path]

IpSpaceChangedSubscriber.new.subscribe outputs['arn']
