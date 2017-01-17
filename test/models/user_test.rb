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

  test 'validates presence of auth_provider' do
    user = users(:regular_user)
    user.auth_provider = nil
    refute user.valid?
  end

  test 'validates presence of uid' do
    user = users(:regular_user)
    user.uid = nil
    refute user.valid?
  end

  test 'allows username to be nil' do
    user = users(:regular_user)
    user.username = nil
    assert user.valid?
  end

  test 'validates uniqueness of username' do
    duplicate_user = User.new
    duplicate_user.auth_provider = 'blah'
    duplicate_user.uid = 'blah'
    assert duplicate_user.valid?

    user = users(:regular_user)
    duplicate_user.username = user.username
    refute duplicate_user.valid?
  end

  test 'validates uniqueness of auth_provider and uid' do
    duplicate_user = User.new
    duplicate_user.auth_provider = 'blah'
    duplicate_user.uid = 'blah'
    assert duplicate_user.valid?

    user = users(:regular_user)
    duplicate_user.auth_provider = user.auth_provider
    duplicate_user.uid = user.uid
    refute duplicate_user.valid?
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
