require "test_helper"

class BugCoveragesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get bug_coverages_index_url
    assert_response :success
  end
end
