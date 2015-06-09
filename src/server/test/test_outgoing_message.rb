require File.expand_path '../test_helper.rb', __FILE__

class OutgoingMessageTest < TtTests

  def test_environment_vars_set_for_plivo_send
    assert ENV['PLIVO_AUTHID']
    assert ENV['PLIVO_TOKEN']
    assert ENV['PLIVO_PHONE_NUMBER']
  end

  def test_om_phones_can_be_created_from_message_group
    om = OutgoingMessage.new(:text => 'outgoing message')
    assert_equal 0, om.phones.count
    mg = MessageGroup.new(:keyword => 'word')
    mg.phones.new(:number => '12223334444')
    mg.phones.new(:number => '12223339999')
    assert mg.save
    om.create_phones_from_message_group(mg)
    assert_equal 2, om.phones.count
  end

  def test_om_has_send_method
    om = OutgoingMessage.new(:text => 'outgoing message')
    assert om.send
  end

  def test_om_phones_can_be_joined_as_string
    om = OutgoingMessage.new(:text => 'outgoing message')
    om.phones.new(:number => 12223334444)
    om.phones.new(:number => 12223339999)
    assert_equal "12223334444<12223339999", om.join_phones
  end

  def test_om_has_text
    om = OutgoingMessage.new(:text => 'outgoing message')
    assert om.save
  end

  def test_om_has_phones
    om = OutgoingMessage.new(:text => 'outgoing message')
    assert_equal om.phones.all.count, 0
    om.phones.new(:number => 12223334444)
    assert om.save
    om.phones.new(:number => 12223339999)
    assert om.save
    assert_equal om.phones.all.count, 2
  end

  def test_outgoing_message_model_exists
    assert OutgoingMessage
  end

end
