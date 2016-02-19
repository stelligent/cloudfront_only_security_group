Beware to do your local development against the JRuby specified in pom.xml so you don't get a horrible
surprise upon deployment to Lambda!

simplecov doesn't play well with JRuby, so you can use Ruby 2.2.x when measuring coverage.

there is a python version that does basically the same thing here:
https://github.com/awslabs/aws-cloudfront-samples/tree/master/update_security_groups_lambda