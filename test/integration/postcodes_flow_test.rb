require 'test_helper'
 
class PostcodesFlowTest < ActionDispatch::IntegrationTest
  test 'should see the form' do
    get '/'

    assert_select 'form input[type=text]', 1
    assert_select 'form input[type=submit]', 1
  end
end
