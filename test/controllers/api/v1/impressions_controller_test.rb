require "test_helper"

class Api::V1::ImpressionsControllerTest < ActionDispatch::IntegrationTest
  test "should get capture" do
    get api_v1_impressions_capture_url
    assert_response :success
  end
end
