#encoding: utf-8

module AccessLog
  class Filter
    def initialize(log_file)
      @log_file = log_file
    end
    def by_ip(ip)
      address = IPAddr.new(ip)
      File.open(@log_file).each do |line|
        request_ip = line.split[0]
        puts line if address.include?(request_ip)
      end
    end
  end
end
