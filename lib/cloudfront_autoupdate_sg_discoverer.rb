require 'aws-sdk'

class CloudfrontAutoUpdateDiscoverer

  def discover(tag_name:'cloudfront-autoupdate')
    ec2_client = Aws::EC2::Client.new
    resource = Aws::EC2::Resource.new(client: ec2_client)

    sg_filters = [
      { name: 'tag-key', values: [tag_name]},
      { name: 'tag-value', values: %w(true)}
    ]
    resource.security_groups(filters: sg_filters).map { |sg| sg.group_id }
  end
end