require 'test_helper'

class HomeLayoutTest < ActionDispatch::IntegrationTest
  test 'home templates loaded' do
    get root_path
    assert_template :index
    assert_template partial: '_headline'
    assert_template partial: '_login'
  end

  test 'can see home layout before login' do
    get root_path
    assert_select 'title', 'Agile Sprint'
    assert_select 'nav'
    assert_select 'a[href=?]', root_path, text: 'Agile Sprint'
    assert_select 'h1', text: 'Plan Your Sprint'
    assert_select 'a[href=?]', '/auth/facebook', text: 'Sign in with Facebook'
    assert_select 'a[href=?]', '/auth/google', text: 'Sign in with Google'
    assert_select 'span.fa-facebook'
    assert_select 'span.fa-google'
  end

  test 'can see home layout after login' do
    OmniAuth.config.test_mode = true
    login(login_data)
    get root_path
    assert_select 'a[href=?]', '/logout', text: 'Log Out'
    assert_select 'img'
    assert_select 'a[href=?]', '/auth/facebook', count: 0, text: 'Sign in with Facebook'
    assert_select 'a[href=?]', '/auth/google', count: 0, text: 'Sign in with Google'
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
