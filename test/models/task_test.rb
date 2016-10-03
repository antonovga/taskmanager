require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  def setup
    @task = tasks(:regular_user_task)
  end

  test 'should not save without name' do
    @task.name = nil

    assert_not @task.valid?
    assert_includes @task.errors, :name
  end

  test 'should not save without user' do
    @task.user_id = nil

    assert_not @task.valid?
    assert_includes @task.errors, :user
  end

  test 'should have initial state "new"' do
    assert @task.new?
  end

  test 'should have valid states' do
    assert_equal @task.aasm.states.map(&:name), [:new, :started, :finished]
  end

  test 'should have start event if newly created' do
    assert_equal @task.aasm.events(permitted: true).map(&:name), [:start]
  end

  test 'should have finish event if is in started state' do
    @task.start

    assert_equal @task.aasm.events(permitted: true).map(&:name), [:finish]
  end
end
