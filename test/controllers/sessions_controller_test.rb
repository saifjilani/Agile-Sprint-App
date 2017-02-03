require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    OmniAuth.config.test_mode = true
  end

  test '#create should create a user' do
    assert_difference('User.count') do
      login(login_data)
      name = login_data[:data][:info][:name]
      assert_equal "Welcome, #{name}", flash[:success]
    end
  end

  test '#create should create a session' do
    login(login_data)
    assert session[:user_id]
  end

  test '#create should redirect to dasboard if success' do
    login(login_data)
    assert_redirected_to dashboard_index_path
  end

  test '#destroy should clear the session' do
    login(login_data)
    assert session[:user_id]
    delete '/logout'
    assert_nil session[:user_id]
  end

  test '#destroy should redirect to home page' do
    login(login_data)
    delete '/logout'
    assert_equal 'See you!', flash[:success]
    assert_redirected_to root_path
  end
end
