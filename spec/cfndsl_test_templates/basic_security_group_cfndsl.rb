CloudFormation {
  Description 'Create a security group for int testing'

  EC2_SecurityGroup('securityGroup') {
    GroupDescription 'inttest Security Group'
    VpcId vpc_id
  }

  EC2_SecurityGroupIngress('ingress') {
    GroupId Ref('securityGroup')
    IpProtocol 'tcp'
    FromPort '22'
    ToPort '22'
    CidrIp '0.0.0.0/0'
  }

  Output(:sgId,
         Ref('securityGroup'))
}
