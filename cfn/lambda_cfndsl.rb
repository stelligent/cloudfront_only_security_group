require 'json'
CloudFormation {
  Description 'Create Lambda function to update an sg with CloudFront IP'

  Lambda_Function('sgUpdaterLambdaFunction') {
    Handler 'JRubyHandlerWrapper::handler'
    Runtime 'java8'
    Timeout 240
    MemorySize 448
    Role FnGetAtt('lambdaExecutionRole', 'Arn')
    Code({
      'S3Bucket' => 'stelligent-binary-artifact-repo',
      'S3Key' => 'cloudfront-only-security-group-1.0.0-SNAPSHOT.jar'
    })
  }

  Lambda_Permission('snsTopicPermission') {
    Action 'lambda:InvokeFunction'
    FunctionName Ref('sgUpdaterLambdaFunction')
    Principal 'sns.amazonaws.com'
    SourceAccount '806199016981'
    SourceArn 'arn:aws:sns:us-east-1:806199016981:AmazonIpSpaceChanged'
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
                  "ec2:*SecurityGroup*"
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
              },
              {
                "Action": [
                  "logs:CreateLogGroup",
                  "logs:CreateLogStream",
                  "logs:PutLogEvents"
                ],
                "Effect": "Allow",
                "Resource": "arn:aws:logs:*:*:*"
              }
            ],
            "Version":"2012-10-17"
          }
        END
        )
      }
    ])
  }

  Output(:arn,
         FnGetAtt('sgUpdaterLambdaFunction', 'Arn'))
  Output(:functionname,
         Ref('sgUpdaterLambdaFunction'))
}