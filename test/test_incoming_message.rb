require File.expand_path '../test_helper.rb', __FILE__

class IncomingMessageTest < TtTests

  def sample_plivo(params = {})
    {
      "To" => "16238665466", 
      "Type" => "sms", 
      "MessageUUID" => "98e71fa8-4443-11e3-8556-842b2b55f84d", 
      "From" => "16025715816", 
      "Text" => "Test "
    }.merge(params)
  end
  
  def phone
    p = Phone.new(:number => 12223334444)
    assert p.save
    p
  end
  
  def test_multiple_calls_to_im_api_creates_multiple_incoming_messages_but_only_one_phone
    post '/api/v1/im', sample_plivo
    assert last_response.ok?
    assert_equal Phone.all.count, 1
    assert_equal Phone.first.incoming_messages.count, 1
    post '/api/v1/im', sample_plivo
    assert last_response.ok?
    assert_equal Phone.all.count, 1
    assert_equal Phone.first.incoming_messages.count, 2
  end
  
  def test_im_api_creates_incoming_message_entry
    assert_equal Phone.all.count, 0
    post '/api/v1/im', sample_plivo
    phone = Phone.first
    assert phone
    assert_equal phone.incoming_messages.count, 1
  end

  def test_im_has_text_field
    im = phone.incoming_messages.new(:raw => sample_plivo, :text => sample_plivo["Text"])
    assert im.save
  end

  def test_im_api_throws_500_if_can_not_save
    post '/api/v1/im', sample_plivo({"From" => 'A'})
    refute last_response.ok?, sample_plivo({"From" => 'A'})
    assert_equal last_response.status, 500
  end

  def test_im_api_creates_phone
    assert_equal Phone.all.count, 0
    post '/api/v1/im', sample_plivo
    assert_equal Phone.all.count, 1
  end

  def test_im_api_throws_500_with_no_message
    post '/api/v1/im', {"From" => "12223334444"}
    refute last_response.ok?
    assert_equal last_response.status, 500    
  end
  
  def test_im_api_throws_500_with_no_from_number
    post '/api/v1/im', {"To" => "12223334444"}
    refute last_response.ok?
    assert_equal last_response.status, 500
  end
  
  def test_im_api_endpoint_exists
    post '/api/v1/im', sample_plivo
    assert last_response.ok?, last_response.inspect
  end

  def test_im_has_association_to_phone
    im = phone.incoming_messages.new()
    im.raw = sample_plivo
    im.text = sample_plivo["Text"]
    assert im.save
  end

  def test_incoming_message_has_raw_text_property
    im = phone.incoming_messages.new(:raw => sample_plivo, :text => sample_plivo["Text"])
    assert im.save
  end

  def test_incoming_message_model_exists
    assert IncomingMessage
  end

end
