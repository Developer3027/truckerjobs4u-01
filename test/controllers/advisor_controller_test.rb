require "test_helper"

class AdvisorControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get advisor_index_url
    assert_response :success
  end
end
