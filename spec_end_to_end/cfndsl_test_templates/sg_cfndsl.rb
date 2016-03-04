CloudFormation {
  Description 'Create a security group for endtoend cloudfrontonlysg testing'

  EC2_SecurityGroup('securityGroup1') {
    GroupDescription 'endtoend cloudfrontonlysg Security Group'
    VpcId vpc_id

    Tags [
             { Key: 'somethingreallyunique', Value: 'true'}
         ]
  }

  Output(:sgId1,
         Ref('securityGroup1'))
}