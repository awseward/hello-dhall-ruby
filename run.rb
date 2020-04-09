require 'active_support/all'
require 'dhall'
require 'pg'
require 'pry'

def connect_db(config)
  config = config.to_h.map { |k,v| [k, v.value] }.to_h.symbolize_keys
  PG.connect(**config)
end

Dhall.load(ARGV[0]).then do |config|
  connect_db(config).exec('SELECT * FROM genuses;') do |results|
    puts(results.to_a)
  end
end
