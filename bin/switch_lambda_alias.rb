#!/usr/bin/env ruby
require 'trollop'
require_relative '../lib/lambda_alias_switcher'

opts = Trollop::options do
  opt :function_name, '', type: :string, required: true
  opt :alias, '', type: :string, required: true
  opt :function_version, '', type: :string, required: false, default: '$LATEST'
end

alias_arn = LambdaAliasSwitcher.new.switch_alias function_name: opts[:function_name],
                                                 alias_arg: opts[:alias],
                                                 function_version: opts[:function_version]
puts alias_arn

