#!/usr/bin/env ruby
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'sinatra/base'
require 'plivo'

require_relative 'models/init_models'


class TtApp < Sinatra::Base

  enable :method_override
  set :public_folder, 'public'

  # home...
  get '/' do
    "<h1>TT</h1>"
  end

end







