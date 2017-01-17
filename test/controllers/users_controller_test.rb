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
    username = 'updated_username'
    patch user_path(user), params: { user: { name: name, username: username } }
    assert_redirected_to user
    user.reload
    assert_equal name, user.name
    assert_equal username, user.username
  end

  test 'should destroy user' do
    user = login(login_data)
    assert_difference('User.count', -1) do
      delete user_url(user)
    end

    assert_redirected_to root_path
  end

  private

  def login_data
    {
      provider: 'facebook',
      data: {
        uid: '12345',
        info: {
          name: 'facebook user',
          image: 'http://graph.facebook.com/v2.6/12345/picture',
          urls: {
            Facebook: 'https://www.facebook.com/app_scoped_user_id/12345/'
          }
        }
      }
    }
  end

  def login(mock_login)
    provider = mock_login[:provider]
    OmniAuth.config.add_mock(provider.to_sym, mock_login[:data])
    get "/auth/#{provider}"
    request.env['omniauth.env'] = OmniAuth.config.mock_auth[provider.to_sym]
    get "/auth/#{provider}/callback"
    User.find_by(id: session[:user_id])
  end
end
