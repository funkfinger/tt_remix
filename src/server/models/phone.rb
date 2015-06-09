class Phone
  include DataMapper::Resource
  property :id, Serial
  property :number, Integer, :required => true, :min => 0, :max => 281474976710656, :unique => true
  property :active, Boolean, :required => true, :default => true
  
  has n, :incoming_messages
end