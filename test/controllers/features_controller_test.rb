require 'test_helper'

class FeaturesControllerTest < ActionDispatch::IntegrationTest
  setup do
    OmniAuth.config.test_mode = true
    @user = login(login_data)
    @sprint = @user.sprints.create(sprint_params)
  end

  test 'should index features' do
    get user_sprint_features_url(@user, @sprint)
    assert_response :success
  end

  test 'should show feature' do
    feature = @sprint.features.create(feature_params)
    get user_sprint_features_url(@user, @sprint, id: feature.id)
    assert_response :success
  end

  test 'should get new feature' do
    get new_user_sprint_feature_url(@user, @sprint)
    assert_response :success
  end

  test 'should edit feature' do
    feature = @sprint.features.create(feature_params)
    get edit_user_sprint_feature_url(@user, @sprint, id: feature.id)
    assert_response :success
  end

  test 'should create feature' do
    post user_sprint_features_url(@user, @sprint), params: { feature: feature_params }
    assert_redirected_to user_sprint_feature_url(id: feature_params[:id])

    feature = @sprint.features.find(feature_params[:id])
    assert_equal feature_params[:title], feature.title
    assert_equal feature_params[:rank], feature.rank
    assert_equal feature_params[:estimated_total_hours], feature.estimated_total_hours
    assert_equal feature_params[:estimated_remaining_hours], feature.estimated_remaining_hours
    assert_equal feature_params[:actual_worked_hours], feature.actual_worked_hours
  end

  test 'should update feature' do
    feature = @sprint.features.create(feature_params)
    patch user_sprint_feature_url(@user, @sprint, id: feature.id), params: { feature: updated_feature_params }
    assert_redirected_to user_sprint_feature_path(id: feature.id)

    feature.reload
    assert_equal updated_feature_params[:title], feature.title
    assert_equal updated_feature_params[:rank], feature.rank
    assert_equal updated_feature_params[:estimated_total_hours], feature.estimated_total_hours
    assert_equal updated_feature_params[:estimated_remaining_hours], feature.estimated_remaining_hours
    assert_equal updated_feature_params[:actual_worked_hours], feature.actual_worked_hours
  end

  test 'should destroy feature' do
    feature = @sprint.features.create(feature_params)
    assert_difference('Feature.count', -1) do
      delete user_sprint_feature_url(@user, @sprint, feature.id)
    end
    assert_redirected_to user_sprint_features_url(@user, @sprint)
  end

  private

  def feature_params
    {
      id: 245,
      title: 'test feature',
      rank: 1,
      estimated_total_hours: 2.5,
      estimated_remaining_hours: 3.5,
      actual_worked_hours: 1.2
    }
  end

  def updated_feature_params
    {
      title: 'updated feature',
      rank: 2,
      estimated_total_hours: 1.5,
      estimated_remaining_hours: 5.5,
      actual_worked_hours: 1.4
    }
  end

  def sprint_params
    {
      id: 123,
      title: 'test',
      start_date: '2017-01-17',
      end_date: '2017-01-17'
    }
  end

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
