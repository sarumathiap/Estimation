require 'test_helper'

class EpicsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get epics_index_url
    assert_response :success
  end

  test "should get show" do
    get epics_show_url
    assert_response :success
  end

end
