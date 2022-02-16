require "test_helper"

class EngineersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get engineers_index_url
    assert_response :success
  end
end
