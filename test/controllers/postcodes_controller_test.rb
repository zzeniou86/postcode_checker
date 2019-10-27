require 'test_helper'

class PostcodesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get postcodes_url

    assert_response :success
  end
end
