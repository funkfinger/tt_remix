ENV['RACK_ENV'] = 'test'
ENV['DB_NAME']='tongue_tied_test'

require 'minitest/autorun'
require 'rack/test'

require File.expand_path '../../tt.rb', __FILE__

def app
  TtApp.new!
end

class TtTests < MiniTest::Test
  include Rack::Test::Methods
  def setup
    DataMapper.auto_migrate!
  end
end
