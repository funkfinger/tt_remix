require File.expand_path '../test_helper.rb', __FILE__

class MessageGroupTest < TtTests

  def test_api_adds_multiple_numbers_to_message_group
    mg = MessageGroup.new(:keyword => 'word')
    assert mg.save
    post '/api/v1/im', {'From' => '12223334444', 'Text' => 'word'}
    assert last_response.ok?
    post '/api/v1/im', {'From' => '12223339999', 'Text' => 'word'}
    assert last_response.ok?
    mg.reload
    assert_equal mg.phones.all.count, 2    
  end

  def test_im_via_api_is_added_to_message_group_if_keyword_is_correct
    mg = MessageGroup.new(:keyword => 'word')
    assert mg.save
    assert_equal mg.phones.all.count, 0
    post '/api/v1/im', {'From' => '12223334444', 'Text' => 'word'}
    assert last_response.ok?
    mg.reload
    assert_equal mg.phones.all.count, 1
  end

  def test_message_group_phones_are_unique
    mg = MessageGroup.new(:keyword => 'word')
    mg.phones.new(:number => '12223334444')
    assert mg.save
    assert_equal mg.phones.all.count, 1
    mg.phones.new(:number => '12223334444')
    refute mg.save
    assert_equal mg.phones.all.count, 1    
  end

  def test_message_group_has_keyword
    mg = MessageGroup.new(:keyword => 'word')
    assert mg.save
  end

  def test_message_group_has_phones
    mg = MessageGroup.new(:keyword => 'word')
    mg.phones.new(:number => '12223334444')
    assert mg.save
  end

  def test_message_group_model_exists
    assert MessageGroup
  end

end