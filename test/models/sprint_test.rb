require 'test_helper'

class SprintTest < ActiveSupport::TestCase
  test 'has_many features' do
    sprint = sprints(:regular_sprint)
    assert_kind_of Feature, sprint.features.first
  end

  test 'has_many users' do
    sprint = sprints(:regular_sprint)
    assert_kind_of User, sprint.users.first
  end

  test 'is valid' do
    sprint = sprints(:regular_sprint)
    assert sprint.valid?
  end

  test 'validates title length' do
    sprint = sprints(:regular_sprint)
    title_greater_than_50 = (0...51).map { ('a'..'z').to_a[rand(26)] }.join
    sprint.title = title_greater_than_50
    refute sprint.valid?
  end

  test 'validates presence of title' do
    sprint = sprints(:regular_sprint)
    sprint.title = nil
    refute sprint.valid?
  end

  test 'validates presence of start_date' do
    sprint = sprints(:regular_sprint)
    sprint.start_date = nil
    refute sprint.valid?
  end

  test 'validates presence of end_date' do
    sprint = sprints(:regular_sprint)
    sprint.end_date = nil
    refute sprint.valid?
  end
end
