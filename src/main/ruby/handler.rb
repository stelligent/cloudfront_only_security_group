require 'aws-sdk'

$LOAD_PATH << 'uri:classloader:/'
require 'cloudfront_only_security_group_updater'

CloudfrontOnlySecurityGroupUpdater.new.update