#encoding: utf-8

module AccessLog
  class Filter
    def initialize(log_file)
      @log_file = log_file
    end
    def by_ip(ip)
      address = IPAddr.new(ip)
      File.open(@log_file).each do |line|
        # Fetch possible proxied ip addresses
        request_ips = line.split[0].split(',').map(&:strip)
        puts line if request_ips.any? { |ip| address.include?(ip) }
      end
    end
  end
end
