require 'test_helper'

class UrlControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get url_new_url
    assert_response :success
  end

end
