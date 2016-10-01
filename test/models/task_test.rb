require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  def setup
    @task = tasks(:valid_task)
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
end
