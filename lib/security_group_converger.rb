require 'aws-sdk'

class SecurityGroupConverger

  def converge_ingress(sg_id:, ingress_rules:)
    security_group = Aws::EC2::SecurityGroup.new(sg_id)

    wipe_ingress_rules(security_group)

    ingress_rules.each do |ingress_rule|
      security_group.authorize_ingress ip_protocol: ingress_rule[:protocol],
                                       from_port: ingress_rule[:port],
                                       to_port: ingress_rule[:port],
                                       cidr_ip: ingress_rule[:cidr]
    end
  end

  private

  #
  # probably need to discover them, cache them, add the new ones then delete the old ones
  # so there is no interruption in service?
  def wipe_ingress_rules(security_group)
    security_group.ip_permissions.each do |ip_permission|
      if ip_permission.ip_ranges.length > 0
        ip_permission.ip_ranges.each do |ip_range|
          security_group.revoke_ingress ip_protocol: ip_permission['ip_protocol'],
                                        from_port: ip_permission['from_port'],
                                        to_port: ip_permission['to_port'],
                                        cidr_ip: ip_range['cidr_ip']
        end
      else
        fail 'something is wrong to be here'
        # ip_permission.user_id_group_pairs.each do |user_id_group_pair|
        #   security_group.revoke_ingress ip_protocol: ip_permission['ip_protocol'],
        #                                 from_port: ip_permission['from_port'],
        #                                 to_port: ip_permission['to_port'],
        #                                 source_security_group_id: user_id_group_pair['group_id']
        # end
      end
    end


  end
end