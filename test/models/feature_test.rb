require 'test_helper'

class FeatureTest < ActiveSupport::TestCase
  test 'belongs_to Sprint' do
    sprint = sprints(:regular_sprint)
    feature = features(:regular_feature)
    assert_equal sprint.id, feature.sprint.id
  end

  test 'validates belongs to sprint' do
    feature = Feature.new
    refute feature.valid?
  end

  test 'is valid' do
    feature = features(:regular_feature)
    assert feature.valid?
  end

  test 'validates title length' do
    feature = features(:regular_feature)
    title_greater_than_50 = (0...51).map { ('a'..'z').to_a[rand(26)] }.join
    feature.title = title_greater_than_50
    refute feature.valid?
  end

  test 'validates presence of rank' do
    feature = features(:regular_feature)
    feature.rank = nil
    refute feature.valid?
  end

  test 'validates presence of estimated_total_hours' do
    feature = features(:regular_feature)
    feature.estimated_total_hours = nil
    refute feature.valid?
  end

  test 'validates presence of estimated_remaining_hours' do
    feature = features(:regular_feature)
    feature.estimated_remaining_hours = nil
    refute feature.valid?
  end

  test 'validates presence of actual_worked_hours' do
    feature = features(:regular_feature)
    feature.actual_worked_hours = nil
    refute feature.valid?
  end
end
