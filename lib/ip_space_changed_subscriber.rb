require 'aws-sdk'

class IpSpaceChangedSubscriber

  def subscribe(lambda_function_arn)
    ip_topic_arn = 'arn:aws:sns:us-east-1:806199016981:AmazonIpSpaceChanged'

    # NOTE: YES INDEED WE DO WANT TO HARD CODE THE REGION, so we can access the topic
    sns_client = Aws::SNS::Client.new(region: 'us-east-1')

    #don't think we can query if we are already subscribed? so just go for it i guess??

    sns_client.subscribe topic_arn: ip_topic_arn,
                         protocol: 'lambda',
                         endpoint: lambda_function_arn
  end
end

