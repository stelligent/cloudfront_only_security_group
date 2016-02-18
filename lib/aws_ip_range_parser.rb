require 'json'

class AwsIpRangeParser

  # region == nil => all regions
  def parse(json:,
            region:nil,
            service:)
    ranges = JSON.load(json)

    fail 'json is malformed.  must have prefixes key' if ranges['prefixes'].nil?

    matching_service_prefixes = ranges['prefixes'].select do |prefix|
      prefix['service'] == service
    end

    fail "#{service} not found in supplied json" unless matching_service_prefixes.size > 0

    matching_service_prefixes = ranges['prefixes'].select do |prefix|
      if region.nil?
        prefix['service'] == service
      else
        prefix['service'] == service and prefix['region'] == region
      end
    end
    matching_service_prefixes.map { |prefixes| prefixes['ip_prefix']}
  end

end