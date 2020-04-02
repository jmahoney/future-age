require 'test_helper'

class IndexControllerTest < ActionDispatch::IntegrationTest
  test "it_should not throw an error" do
      get root_url
      assert_response :success
  end
end
