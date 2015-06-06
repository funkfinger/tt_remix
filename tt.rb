#!/usr/bin/env ruby
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'sinatra/base'
require 'plivo'

require_relative 'models/init_models'
require_relative 'routes/routes'
require_relative 'helpers/helpers'


class TtApp < Sinatra::Base

  enable :method_override
  set :public_folder, 'public'
  
  def get_keyword(text)
    text.match(/^\s*(\S*)/)
    $1
  end

  # home...
  get '/' do
    "<h1>TT</h1>"
  end

end





