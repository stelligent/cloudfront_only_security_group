#!/usr/bin/env ruby
require 'trollop'
require_relative '../lib/lambda_alias_switcher'

opts = Trollop::options do
  opt :function_name, '', type: :string, required: true
  opt :alias, '', type: :string, required: true
end

alias_arn = LambdaAliasSwitcher.new.switch_alias_of_latest function_name: opts[:stack_name],
                                                           alias_arg: opts[:alias]
puts alias_arn

