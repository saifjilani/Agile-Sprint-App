require 'test_helper'

class SprintsControllerTest < ActionDispatch::IntegrationTest
  setup do
    OmniAuth.config.test_mode = true
    @user = login(login_data)
  end

  test 'should index sprints' do
    get user_sprints_url(@user)
    assert_response :success
  end

  test 'should show sprint' do
    sprint = @user.sprints.create(sprint_params)
    get user_sprint_url(@user, id: sprint.id)
    assert_response :success
  end

  test 'should get new sprint' do
    sprint = @user.sprints.create(sprint_params)
    get new_user_sprint_url(@user)
    assert_response :success
  end

  test 'should edit sprint' do
    sprint = @user.sprints.create(sprint_params)
    get edit_user_sprint_url(@user, id: sprint.id)
    assert_response :success
  end

  test 'should create sprint' do
    post user_sprints_url(@user), params: { sprint: sprint_params }
    assert_redirected_to user_sprint_path(id: sprint_params[:id])

    sprint = @user.sprints.find(sprint_params[:id])
    assert_equal sprint_params[:title], sprint.title
    assert_equal sprint_params[:start_date], sprint.start_date.to_s
    assert_equal sprint_params[:end_date], sprint.end_date.to_s
  end

  test 'should update sprint' do
    sprint = @user.sprints.create(sprint_params)
    patch user_sprint_url(@user, id: sprint.id), params: { sprint: updated_sprint_params }
    assert_redirected_to user_sprint_path(id: sprint.id)

    sprint.reload
    assert_equal updated_sprint_params[:title], sprint.title
    assert_equal updated_sprint_params[:start_date], sprint.start_date.to_s
    assert_equal updated_sprint_params[:end_date], sprint.end_date.to_s
  end

  test 'should destroy sprint' do
    sprint = @user.sprints.create(sprint_params)
    assert_difference('SprintUser.count', -1) do
      delete user_sprint_url(@user, sprint.id)
    end

    assert_redirected_to user_sprints_url(@user)
  end

  private

  def sprint_params
    {
      id: 123,
      title: 'test',
      start_date: '2017-01-17',
      end_date: '2017-01-17'
    }
  end

  def updated_sprint_params
    {
      title: 'updated_title',
      start_date: '2017-01-18',
      end_date: '2017-02-17'
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
