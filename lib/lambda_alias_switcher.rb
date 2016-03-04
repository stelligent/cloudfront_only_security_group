require 'aws-sdk'

class LambdaAliasSwitcher

  def switch_alias_of_latest(function_name:,
                             alias_arg:)
    puts 'should not be here'
    switch_alias function_name: function_name,
                 alias_arg: alias_arg,
                 function_version: '$LATEST'
  end

  def switch_alias(function_name:,
                   alias_arg:,
                   function_version:)
    puts 'switch_alias'

    fail 'function name is nil' if function_name.nil?
    fail 'alias arg is nil' if alias_arg.nil?

    client = Aws::Lambda::Client.new

    list_aliases_response = client.list_aliases function_name: function_name

    puts "list_aliases_response: #{list_aliases_response}"

    found_alias = list_aliases_response.aliases.find do |alias_iter|
      alias_iter.name == alias_arg
    end

    puts "found_alias: #{found_alias}"


    if found_alias.nil?
      puts "create_alias: #{function_name} #{alias_arg} #{function_version} "

      create_alias_response = client.create_alias function_name: function_name,
                                                  name: alias_arg,
                                                  function_version: function_version

      create_alias_response.alias_arn
    else
      puts "update alias: #{function_name} #{alias_arg} #{function_version} "
      update_alias_response = client.update_alias function_name: function_name,
                                                  name: alias_arg,
                                                  function_version: function_version
      update_alias_response.alias_arn
    end
  end
end