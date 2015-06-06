require 'data_mapper'
require 'dm-validations'

require_relative 'phone'

db_connection_string = "postgres://#{ENV['PG_USER']}:#{ENV['PG_PASSWORD']}@#{ENV['DB_HOST']}/#{ENV['DB_NAME']}"
DataMapper.setup(:default, db_connection_string)

# DataMapper.auto_migrate!
# DataMapper.finalize
DataMapper.auto_upgrade!
