require "test_helper"

class RoomsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get rooms_url
    assert_response :success
  end

  test "should get show" do
    get room_url(rooms(:one))
    assert_response :success
  end
end
