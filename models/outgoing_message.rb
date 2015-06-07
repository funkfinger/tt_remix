class OutgoingMessage
  include DataMapper::Resource
  property :id, Serial
  property :text, String, :required => true, :length => 180
  
  has n, :phones, :through => Resource
  
  def create_phones_from_message_group(mg)
    mg.phones.each do |p|
      self.phones << p
    end
    self.save
  end
  
  def send
    # params = {
    #   'src' => from_number,
    #   'dst' => to_number,
    #   'text' => message,
    #   'type' => 'sms'
    # }
    # p = Plivo::RestAPI.new(ENV['PLIVO_AUTHID'], ENV['PLIVO_TOKEN'])
    #     p = Plivo::RestAPI.new(ENV['PLIVO_AUTHID'], ENV['PLIVO_TOKEN'])
    #     response = p.send_message(params)
    #     return response[0] < 400 ? true : false
    #     super
    #   end
    # end
    #
    true
  end
  
  def join_phones
    self.phones.map{|p| p.number}.join("<")
  end
  
end