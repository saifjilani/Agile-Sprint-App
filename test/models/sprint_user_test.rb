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

  test 'is valid' do
    sprint_user = sprint_users(:regular_sprint_user)
    assert sprint_user.valid?
  end

  test 'validates belongs to Sprint' do
    sprint_user = sprint_users(:regular_sprint_user)
    sprint_user.sprint = nil
    refute sprint_user.valid?
  end

  test 'validates belongs to User' do
    sprint_user = sprint_users(:regular_sprint_user)
    sprint_user.user = nil
    refute sprint_user.valid?
  end
end
