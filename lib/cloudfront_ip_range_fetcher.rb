require 'open-uri'

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