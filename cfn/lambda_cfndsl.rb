require 'json'
CloudFormation {
  Description 'Create Lambda function to update an sg with CloudFront IP'

  Lambda_Function('sgUpdaterLambdaFunction') {
    Handler 'JRubyHandlerWrapper::handler'
    Runtime 'java8'
    Timeout 240
    MemorySize 512
    Role FnGetAtt('lambdaExecutionRole', 'Arn')
    Code({
      'S3Bucket' => 'stelligent-binary-artifact-repo',
      'S3Key' => 'cloudfront-only-security-group-1.0.0-SNAPSHOT.jar',
      'S3ObjectVersion' => 'YVXfy1Jly49xDcdkmDMfSxWOKeZ3aGQv'
    })
  }

  IAM_Role('lambdaExecutionRole') {
    AssumeRolePolicyDocument(JSON.load <<-END
      {
        "Statement":[
          {
            "Action":[
              "sts:AssumeRole"
            ],
            "Effect":"Allow",
            "Principal":{
              "Service":[
                "lambda.amazonaws.com"
              ]
            }
          }
        ],
        "Version":"2012-10-17"
      }
    END
    )

    Policies([
      {
        'PolicyName' => 'ReceiveMessagesAndUpdateSecGroups',
        'PolicyDocument' => (JSON.load <<-END
          {
            "Statement":[
              {
                "Action":[
                  "ec2:AuthorizeSecurityGroupEgress",
                  "ec2:AuthorizeSecurityGroupIngress",
                  "ec2:RevokeSecurityGroupEgress",
                  "ec2:RevokeSecurityGroupIngress"
                ],
                "Effect":"Allow",
                "Resource":"*"
              },
              {
                "Action":[
                  "sns:List*",
                  "sns:Get*",
                  "sns:Confirm*",
                  "sns:Subscribe"
                ],
                "Effect":"Allow",
                "Resource":"*"
              }
            ],
            "Version":"2012-10-17"
          }
        END
        )
      }
    ])
  }
}