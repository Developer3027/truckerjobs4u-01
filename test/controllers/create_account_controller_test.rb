require "test_helper"

class CreateAccountControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get create_account_index_url
    assert_response :success
  end
end
