require 'aws-sdk'

class SecurityGroupConverger

  def converge_ingress(sg_id:, ingress_rules:)
    security_group = Aws::EC2::SecurityGroup.new(sg_id)

    wipe_ingress_rules(security_group)

    ip_permissions_to_authorize = ingress_rules.map do |ingress_rule|
      {
        ip_protocol: ingress_rule[:protocol],
        from_port: ingress_rule[:port],
        to_port: ingress_rule[:port],
        ip_ranges: [{ cidr_ip: ingress_rule[:cidr] }]
      }
    end
    unless ip_permissions_to_authorize.empty?
      security_group.authorize_ingress ip_permissions: ip_permissions_to_authorize
    end
  end

  private

  #
  # probably need to discover them, cache them, add the new ones then delete the old ones
  # so there is no interruption in service?
  def wipe_ingress_rules(security_group)
    security_group.ip_permissions.each do |ip_permission|
      if ip_permission.ip_ranges.length > 0
        permissions_to_revoke = ip_permission.ip_ranges.map do |ip_range|
          {
            ip_protocol: ip_permission['ip_protocol'],
            from_port: ip_permission['from_port'],
            to_port: ip_permission['to_port'],
            ip_ranges: [{ cidr_ip: ip_range['cidr_ip'] }]
          }
        end
        security_group.revoke_ingress ip_permissions: permissions_to_revoke
      else
        fail 'something is wrong to be here - should be no source sg'
      end
    end
  end
end