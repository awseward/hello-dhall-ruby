require 'active_support/all'
require 'dhall'
require 'pg'
require 'pry'

def connect_db(pg_config)
  config = pg_config.to_h.map { |k,v| [k, v.value] }.to_h.deep_symbolize_keys
  PG.connect(**config)
end

# binding.pry
Dhall.load(ARGV[0]).then do |config|
  @pg_config = config[:pg]
  @tables = config[:tables]

  @tables.each do |table|
    connect_db(@pg_config).exec("SELECT * FROM #{table['name'].value};") do |results|
      puts results.to_a
    end
  end
end
