require 'open-uri'
require_relative 'aws_ip_range_parser'

class CloudFrontIpRangeFetcher
  IP_RANGE_ENDPOINT = 'https://ip-ranges.amazonaws.com/ip-ranges.json'

  def fetch
    uri = URI.parse endpoint

    AwsIpRangeParser.new.parse json: uri.read,
                               service: 'CLOUDFRONT'
  end

  private

  def endpoint
    IP_RANGE_ENDPOINT
  end
end