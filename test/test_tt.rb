require File.expand_path '../test_helper.rb', __FILE__

class Tt < TtTests

  def test_app_sanity
    get "/"
    assert last_response.ok?
  end

end