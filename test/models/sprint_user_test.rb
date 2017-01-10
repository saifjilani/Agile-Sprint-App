require 'test_helper'

class SprintUserTest < ActiveSupport::TestCase
  test 'belongs_to Sprint' do
    sprint = sprints(:regular_sprint)
    sprint_user = sprint_users(:regular_sprint_user)
    assert_equal sprint.id, sprint_user.sprint.id
  end

  test 'belongs_to User' do
    user = users(:regular_user)
    sprint_user = sprint_users(:regular_sprint_user)
    assert_equal user.id, sprint_user.user.id
  end
end
