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

  test '#create should redirect to root' do
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
  end
end
