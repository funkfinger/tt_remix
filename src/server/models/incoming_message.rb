class IncomingMessage
  include DataMapper::Resource
  property :id, Serial
  property :raw, Text, :required => true
  property :text, String, :length => 160, :required => true
  
  belongs_to :phone
end