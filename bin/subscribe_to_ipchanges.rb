#!/usr/bin/env ruby
require 'trollop'
require_relative 'lib/ip_space_changed_subscriber'

opts = Trollop::options do
  opt :arn, '', type: :string, required: true
end

IpSpaceChangedSubscriber.new.subscribe opts[:arn]