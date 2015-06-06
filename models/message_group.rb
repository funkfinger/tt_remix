class MessageGroup
  include DataMapper::Resource
  property :id, Serial
  property :keyword, String, :length => 160, :required => true
  
  has n, :phones, :through => Resource
end