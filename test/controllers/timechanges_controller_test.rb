require 'test_helper'

class TimechangesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get timechanges_new_url
    assert_response :success
  end

  test "should get create" do
    get timechanges_create_url
    assert_response :success
  end

end
