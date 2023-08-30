require "test_helper"

class Api::V1::ConsentsControllerTest < ActionDispatch::IntegrationTest
  test "should get capture" do
    get api_v1_consents_capture_url
    assert_response :success
  end
end
