require_relative 'cloudfront_ip_range_fetcher'
require_relative 'cloudfront_autoupdate_sg_discoverer'
require_relative 'security_group_converger'

class CloudfrontOnlySecurityGroupUpdater

  def update(tag_name:'cloudfront-autoupdate', port: 80)
    cloudfront_ip_ranges = fetcher.fetch
    ingress_rules = cloudfront_ip_ranges.map { |ip_range| { cidr: ip_range, port: port, protocol: 'tcp' } }

    security_group_ids = CloudfrontAutoUpdateDiscoverer.new.discover(tag_name: tag_name)

    security_group_ids.each do |security_group_id|
      SecurityGroupConverger.new.converge_ingress sg_id: security_group_id,
                                                  ingress_rules: ingress_rules
    end

    security_group_ids
  end

  private

  def fetcher
    CloudFrontIpRangeFetcher.new
  end
end