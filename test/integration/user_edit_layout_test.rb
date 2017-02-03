require 'test_helper'

class UserEditLayoutTest < ActionDispatch::IntegrationTest
  include NavbarInterfaceTest

  setup do
    OmniAuth.config.test_mode = true

    @user = login(login_data)
    get edit_user_path(@user)
  end

  test 'can see login navbar' do
    valid_login_navbar?(@user)
  end

  test 'can see edit user profile' do
    assert_select 'h3.panel-title', 'User Profile'
    assert_select 'div.panel-body'
    assert_select 'img.img-circle'
    assert_select 'form input[type=submit][value=Save]'
  end

  test 'can see delete user' do
    assert_select 'h3.panel-title', 'Delete Account'
    assert_select 'div.panel-body'
    assert_select 'form input[type=submit][value="Delete Your Account"]'
  end
end
