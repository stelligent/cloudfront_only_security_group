Feature:
  As a devsecops guy
  I would like to have a security group of my choice
  only allow cloudfront ingress and keep in step with changes to cloudfront ips


Scenario:
  Given a security group id
  When cloudfront ip is changed
  Then only cloudfront ip are allowed on ingress