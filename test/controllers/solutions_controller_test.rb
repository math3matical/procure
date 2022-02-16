require "test_helper"

class SolutionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get solutions_index_url
    assert_response :success
  end
end
