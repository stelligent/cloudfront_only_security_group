require 'spec_helper'
require 'cloudfront_ip_range_fetcher'

describe CloudFrontIpRangeFetcher do
  it 'returns the cloudfront endpoints across the world' do
    endpoints = CloudFrontIpRangeFetcher.new.fetch

    expect(endpoints.size).to be > 0

    puts endpoints
  end
end