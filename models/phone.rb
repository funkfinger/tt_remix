class Phone
  include DataMapper::Resource
  property :id, Serial
  property :number, String, :required => true, :length => 16
  property :active, Boolean, :required => true, :default => true
end