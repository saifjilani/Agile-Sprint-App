require 'test_helper'

class HomeLayoutTest < ActionDispatch::IntegrationTest
  test 'home templates loaded' do
    get root_path
    assert_template :index
    assert_template partial: '_headline'
    assert_template partial: '_login'
    assert_template partial: '_footer'
  end

  test 'can see home layout' do
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

  test 'can see login layout' do
    OmniAuth.config.test_mode = true
    login(login_data)
    get root_path
    assert_select 'a[href=?]', '/logout', text: 'Log Out'
    assert_select 'img'
    assert_select 'a[href=?]', '/auth/facebook', count: 0, text: 'Sign in with Facebook'
    assert_select 'a[href=?]', '/auth/google', count: 0, text: 'Sign in with Google'
  end

  test 'can see how it works section' do
    get root_path
    assert_select 'a[href=?]', '#how-it-works', text: 'How It Works'
    assert_select 'div#how-it-works'
    assert_select 'h2.section-heading', text: 'How It Works'
    assert_select 'i.fa-tasks'
    assert_select 'i.fa-hourglass-o'
    assert_select 'i.fa-user-plus'
    assert_select 'p.lead', text: 'Create Tasks'
    assert_select 'p.lead', text: 'Estimate Hours'
    assert_select 'p.lead', text: 'Assign Sprinters'
  end

  test 'can see footer' do
    get root_path
    assert_select 'a[href=?]', 'https://github.com/saifjilani/Agile-Sprint-App'
    assert_select 'i.fa-github'
    assert_select 'p.copyright', text: "Copyright \u00A9 2017. All Rights Reserved"
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
