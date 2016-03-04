#!/usr/bin/env ruby
require 'trollop'
require_relative '../lib/cloudformation_converger'

opts = Trollop::options do
  opt :stack_name, '', type: :string, required: true
  opt :path, '', type: :string, required: true
end

outputs = CloudformationConverger.new.converge stack_name: opts[:stack_name],
                                               stack_path: opts[:path]

puts outputs['functionname']