require 'spec_helper'
require 'aws_ip_range_parser'

describe AwsIpRangeParser do

  context 'service not mentioned in document' do
    it 'raises an exception' do
      aws_ip_range_parser = AwsIpRangeParser.new
      expect {
        aws_ip_range_parser.parse json: '{}',
                                  region: 'eu-west-1',
                                  service: 'FOO'
      }.to raise_error 'json is malformed.  must have prefixes key'

      expect {
        aws_ip_range_parser.parse json: '{"prefixes":[ {"foo":"moo"}]}',
                                  region: 'eu-west-1',
                                  service: 'FOO'
      }.to raise_error 'FOO not found in supplied json'
    end
  end


  context 'service mentioned in document' do

    context 'with a particular region' do
      it 'returns an array of cidrs for that service, region combination' do

        expected_cidr = %w(
          52.84.0.0/15
          54.182.0.0/16
          54.192.0.0/16
          54.230.0.0/16
          54.239.128.0/18
          54.239.192.0/19
          54.240.128.0/18
          204.246.164.0/22
          204.246.168.0/22
          204.246.174.0/23
          204.246.176.0/20
          205.251.192.0/19
          205.251.249.0/24
          205.251.250.0/23
          205.251.252.0/23
          205.251.254.0/24
          216.137.32.0/19
        )
        aws_ip_range_parser = AwsIpRangeParser.new
        actual_cidr = aws_ip_range_parser.parse json: IO.read(File.join(__dir__, 'valid_prefixes.json')),
                                                region: 'GLOBAL',
                                                service: 'CLOUDFRONT'

        expect(actual_cidr).to eq expected_cidr
      end
    end

    context 'without a particular region' do
      it 'returns all cidrs for the service worldwide' do
        expected_cidr = %w(
          52.84.0.0/15
          54.182.0.0/16
          54.192.0.0/16
          54.230.0.0/16
          54.239.128.0/18
          54.239.192.0/19
          54.240.128.0/18
          204.246.164.0/22
          204.246.168.0/22
          204.246.174.0/23
          204.246.176.0/20
          205.251.192.0/19
          205.251.249.0/24
          205.251.250.0/23
          205.251.252.0/23
          205.251.254.0/24
          216.137.32.0/19
        )
        aws_ip_range_parser = AwsIpRangeParser.new
        actual_cidr = aws_ip_range_parser.parse json: IO.read(File.join(__dir__, 'valid_prefixes.json')),
                                                service: 'CLOUDFRONT'

        expect(actual_cidr).to eq expected_cidr
      end
    end
  end
end