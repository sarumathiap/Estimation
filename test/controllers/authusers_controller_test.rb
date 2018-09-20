require 'test_helper'

class AuthusersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @authuser = authusers(:one)
  end

  test "should get index" do
    get authusers_url
    assert_response :success
  end

  test "should get new" do
    get new_authuser_url
    assert_response :success
  end

  test "should create authuser" do
    assert_difference('Authuser.count') do
      post authusers_url, params: { authuser: { email: @authuser.email, role: @authuser.role, status: @authuser.status } }
    end

    assert_redirected_to authuser_url(Authuser.last)
  end

  test "should show authuser" do
    get authuser_url(@authuser)
    assert_response :success
  end

  test "should get edit" do
    get edit_authuser_url(@authuser)
    assert_response :success
  end

  test "should update authuser" do
    patch authuser_url(@authuser), params: { authuser: { email: @authuser.email, role: @authuser.role, status: @authuser.status } }
    assert_redirected_to authuser_url(@authuser)
  end

  test "should destroy authuser" do
    assert_difference('Authuser.count', -1) do
      delete authuser_url(@authuser)
    end

    assert_redirected_to authusers_url
  end
end
