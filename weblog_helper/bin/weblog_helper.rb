#!/usr/bin/env ruby

require_relative '../lib/access_log'

def show_help(message='Show this help')
  ident = " " * 2
  puts "#{message}"
  puts ""
  puts "Usage: #{File.basename(__FILE__)} [options]"
  puts "#{ident}--ip=<ip>           Mandatory: Can be either an ip address or a CDIR range"
  puts "#{ident}--log-file=<path>   Mandatory: Path to the access log file"
  puts ""
  puts "Example:"
  puts "#{ident}./#{File.basename(__FILE__)} --ip=180.76.15.0/24 --log-file=./data/public_access.log.txt"
  puts "#{ident}./#{File.basename(__FILE__)} --ip=178.93.28.59 --log-file=./data/public_access.log.txt"
  puts ""
  exit(1)
end

options = {}

ARGV.each do |opt|
  opt = opt.split('=', 2)
  case opt[0]
  when '--ip'
    options[:ip] = opt[1]
  when '--log-file'
    options[:log_file] = opt[1]
  else
    show_help("#{opt[0]} is not recognized as a valid option")
  end
end

required_options = [:ip, :log_file]

required_options.each do |opt|
  show_help("A required option is missing: #{opt}") if ! options.include?(opt)
end

begin
  IPAddr.new(options[:ip])
rescue Exception => e
  show_help("Error: The Ip address [#{options[:ip]}] is not valid - #{e}")
  exit(2)
end

AccessLog::Filter.new(options[:log_file]).by_ip(options[:ip])

