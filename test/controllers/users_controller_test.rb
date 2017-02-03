require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    OmniAuth.config.test_mode = true
  end

  test 'should show user' do
    user = login(login_data)
    get user_url(user)
    assert_response :success
  end

  test 'should edit user' do
    user = login(login_data)
    get edit_user_path(user)
    assert_response :success
  end

  test 'should update user' do
    user = login(login_data)
    name = 'updated name'
    patch user_path(user), params: { user: { name: name } }
    assert_redirected_to user
    user.reload
    assert_equal name, user.name
  end

  test 'should destroy user' do
    user = login(login_data)
    assert_difference('User.count', -1) do
      delete user_url(user)
    end

    assert_redirected_to root_path
  end
end
