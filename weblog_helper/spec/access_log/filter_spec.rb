require_relative '../spec_helper'

real_access_log = File.join(File.dirname(__FILE__), '../..', 'data/public_access.log.txt')
fixtures_access_log = File.join(File.dirname(__FILE__),'fixtures_access_log.txt')
fixtures = YAML.load(File.open(File.join(File.dirname(__FILE__),'resources.yaml')))

puts fixtures_access_log

describe AccessLog::Filter do
  describe '.by_ip' do
    it 'should raise error when ip is not valid' do
      expect { AccessLog::Filter.new('null').by_ip('127')}.to raise_error(IPAddr::InvalidAddressError)
    end
    it 'should raise error when the file does not exists' do
      expect { AccessLog::Filter.new('my_non_existent_file').by_ip('127.0.0.1')}.to raise_error(Errno::ENOENT)
    end

    let(:fixtures_access_log_filter) { AccessLog::Filter.new(fixtures_access_log) }
  
    fixtures.each do |fixture|
      it 'should output the correct lines to stdout from fixtures' do
        expect { fixtures_access_log_filter.by_ip(fixture['ip']) }.to output(fixture['output']).to_stdout
      end
    end

    let(:access_log_filter) { AccessLog::Filter.new(real_access_log) }
 
    it 'should output the correct line to stdout from a real access log file' do
      expect { access_log_filter.by_ip('104.224.28.232') }.to output("104.224.28.232 - - [03/Jun/2015:03:40:22 -0700] \"GET /logs/access.log HTTP/1.1\" 200 2900951 \"http://redlug.com/\" \"Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36 OPR/26.0.1656.60\" \"redlug.com\"\n").to_stdout
    end 

  end
end
