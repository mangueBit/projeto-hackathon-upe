require 'test_helper'

class SensorControllerTest < ActionDispatch::IntegrationTest
  test "should get register" do
    get sensor_register_url
    assert_response :success
  end

  test "should get update" do
    get sensor_update_url
    assert_response :success
  end

end
