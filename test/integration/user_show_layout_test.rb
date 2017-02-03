require 'test_helper'

class UserShowLayoutTest < ActionDispatch::IntegrationTest
  include NavbarInterfaceTest

  setup do
    OmniAuth.config.test_mode = true
  end

  test 'can see login navbar' do
    user = login(login_data)
    get user_path(user)
    valid_login_navbar?(user)
  end

  test 'can see user profile' do
    user = login(login_data)
    get user_path(user)

    assert_select 'h3.panel-title', 'User Profile'
    assert_select 'div.panel-body'
    assert_select 'img.img-circle'
    assert_select 'a[href=?]', edit_user_path(user), text: 'Edit'
  end
end
