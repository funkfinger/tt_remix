class OutgoingMessage
  include DataMapper::Resource
  property :id, Serial
  property :text, String, :required => true, :length => 180
  
  has n, :phones, :through => Resource
  
  def send
    true
  end
  
  def join_phones
    self.phones.map{|p| p.number}.join("<")
  end
  
end