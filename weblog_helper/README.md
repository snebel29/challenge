# An access_log filter by ip (ipv4 and ipv6) tool

Install rvm
```
https://rvm.io/rvm/install
rvm install ruby-2.3.1
```

```
gem install bundler
bundle install
```

Tests
```
rake
```

Usage
```
Usage: weblog_helper.rb [options]
  --ip=<ip>           Mandatory: Can be either an ip address or a CDIR range
  --log-file=<path>   Mandatory: Path to the access log file

Example:
  ./weblog_helper.rb --ip=180.76.15.0/24 --log-file=./data/public_access.log.txt
  ./weblog_helper.rb --ip=178.93.28.59 --log-file=./data/public_access.log.txt

```

