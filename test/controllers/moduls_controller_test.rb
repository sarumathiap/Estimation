require 'test_helper'

class ModulsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @modul = moduls(:one)
  end

  test "should get index" do
    get moduls_url
    assert_response :success
  end

  test "should get new" do
    get new_modul_url
    assert_response :success
  end

  test "should create modul" do
    assert_difference('Modul.count') do
      post moduls_url, params: { modul: { name: @modul.name } }
    end

    assert_redirected_to modul_url(Modul.last)
  end

  test "should show modul" do
    get modul_url(@modul)
    assert_response :success
  end

  test "should get edit" do
    get edit_modul_url(@modul)
    assert_response :success
  end

  test "should update modul" do
    patch modul_url(@modul), params: { modul: { name: @modul.name } }
    assert_redirected_to modul_url(@modul)
  end

  test "should destroy modul" do
    assert_difference('Modul.count', -1) do
      delete modul_url(@modul)
    end

    assert_redirected_to moduls_url
  end
end
