CloudFormation {
  Description 'Create a security group for int testing'

  EC2_SecurityGroup('securityGroup1') {
    GroupDescription 'inttest Security Group'
    VpcId vpc_id

    Tags [
      { Key: 'somethingratherunique', Value: 'true'}
    ]
  }

  EC2_SecurityGroup('securityGroup2') {
    GroupDescription 'inttest Security Group'
    VpcId vpc_id

    Tags [
      { Key: 'somethingratherunique', Value: 'false'}
    ]
  }

  EC2_SecurityGroup('securityGroup3') {
    GroupDescription 'inttest Security Group'
    VpcId vpc_id
  }

  Output(:sgId1,
         Ref('securityGroup1'))

  Output(:sgId2,
         Ref('securityGroup2'))

  Output(:sgId3,
         Ref('securityGroup3'))
}
