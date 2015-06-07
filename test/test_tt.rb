require File.expand_path '../test_helper.rb', __FILE__

class Tt < TtTests

  def test_environment_vars_for_pg_connection
    assert ENV['PG_USER']
    assert ENV['PG_PASSWORD']
    assert ENV['DB_HOST']
    assert ENV['DB_NAME']
  end

  def test_environment_vars_exist
    assert_equal 'bar', ENV['FOO']
  end

  def test_get_keyword
    assert_equal app.get_keyword('key word'), 'key'
  end

  def test_app_sanity
    get "/"
    assert last_response.ok?
  end

end