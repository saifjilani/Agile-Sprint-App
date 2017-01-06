require 'test_helper'

class SprintTest < ActiveSupport::TestCase
  test 'has_many features' do
    sprint = sprints(:regular_sprint)
    assert_kind_of Feature, sprint.features.first
  end
end
