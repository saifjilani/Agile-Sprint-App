require 'test_helper'

class FeatureTest < ActiveSupport::TestCase
  test 'belongs_to Sprint' do
    sprint = sprints(:regular_sprint)
    feature = features(:regular_feature)
    assert_equal sprint.id, feature.sprint.id
  end
end
