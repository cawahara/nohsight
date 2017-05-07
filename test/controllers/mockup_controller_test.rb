require 'test_helper'

class MockupControllerTest < ActionDispatch::IntegrationTest
  test "should get dashboard" do
    get mockup_dashboard_url
    assert_response :success
  end

  test "should get search" do
    get mockup_search_url
    assert_response :success
  end

  test "should get detail" do
    get mockup_detail_url
    assert_response :success
  end

end
