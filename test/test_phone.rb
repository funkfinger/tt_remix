require File.expand_path '../test_helper.rb', __FILE__

class PhoneTest < TtTests
  
  def test_phone_has_active_or_not
    n = Phone.new(:number => 12223334444)
    assert n.save
    assert n.active
    n.active = false
    assert n.save
    refute n.active
  end
  
  def test_phone_is_unique
    n = Phone.new(:number => 12223334444)
    assert n.save
    n = Phone.new(:number => 12223334444)
    refute n.save
  end
  
  def test_phone_has_numbers
    n = Phone.new(:number => 12223334444)
    assert n.save
  end
  
  def test_class_exists
    assert Phone
  end

end