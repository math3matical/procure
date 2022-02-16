require "test_helper"

class CaseCoveragesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get case_coverages_index_url
    assert_response :success
  end
end
