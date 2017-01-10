require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'has_many sprints' do
    user = users(:regular_user)
    assert_kind_of Sprint, user.sprints.first
  end

  test 'find_by_provider_and_uid returns a user' do
    user = users(:regular_user)
    found_user = User.find_by_provider_and_uid(provider: user.auth_provider, uid: user.uid)
    assert_equal user, found_user
  end

  test 'find_by_provider_and_uid returns nil for new user' do
    provider = 'new_provder'
    uid = 1111

    assert_nil User.find_by_provider_and_uid(provider: provider, uid: uid)
  end

  test 'create_with_omniauth creates a new user' do
    assert_difference('User.count') do
      User.create_with_omniauth(auth_hash: auth_hash)
    end
  end

  private

  def auth_hash
    {
      provider: 'facebook',
      uid: '12345',
      info: {
        name: 'facebook user',
        image: 'http://graph.facebook.com/v2.6/12345/picture',
        urls: {
          Facebook: 'https://www.facebook.com/app_scoped_user_id/12345/'
        }
      }
    }.with_indifferent_access
  end
end
