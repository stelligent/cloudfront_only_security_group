$LOAD_PATH << 'uri:classloader:/'
require 'cloudfront_only_security_group_updater'

tag_name = $lambdaInputMap['tag_name']
port = $lambdaInputMap['port']

if tag_name.nil? and port.nil?
  CloudfrontOnlySecurityGroupUpdater.new.update
else
  CloudfrontOnlySecurityGroupUpdater.new.update tag_name: tag_name,
                                                port: port.to_i
end

