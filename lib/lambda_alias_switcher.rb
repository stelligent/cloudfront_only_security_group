require 'aws-sdk'

class LambdaAliasSwitcher

  def switch_alias_of_latest(function_name:,
                             alias_arg:)
    fail if function_name.nil?
    fail if alias_arg.nil?

    puts "function_name: #{function_name}"

    client = Aws::Lambda::Client.new

    puts "client config: #{client.config}"
    puts 'code: list_aliases_response = client.list_aliases function_name: function_nameå'
    list_aliases_response = client.list_aliases function_name: function_name

    found_alias = list_aliases_response.aliases.find do |alias_iter|
      alias_iter.name == alias_arg
    end

    if found_alias.nil?
      create_alias_response = client.create_alias function_name: function_name,
                                                  name: alias_arg,
                                                  function_version: '$LATEST'

      create_alias_response.alias_arn
    else
      update_alias_response = client.update_alias function_name: function_name,
                                                  name: alias_arg,
                                                  function_version: '$LATEST'
      update_alias_response.alias_arn
    end
  end
end