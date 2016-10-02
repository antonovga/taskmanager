require 'test_helper'

class Web::TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in
    @task = tasks(:regular_user_task)
  end

  test 'should get index' do
    get tasks_path
    assert_response :success
  end

  test 'should get new' do
    get new_task_path
    assert_response :success
  end

  test 'should get edit' do
    get edit_task_url(@task)
    assert_response :success
  end

  test 'should create task' do
    assert_difference('Task.count') do
      post tasks_url, params: { task: { name: 'new_task' } }
    end

    assert_redirected_to tasks_path
  end

  test 'should update task' do
    new_task_name = 'update name'
    patch task_url(@task), params: { task: { name: new_task_name } }
    @task.reload

    assert_redirected_to tasks_path
    assert_equal @task.name, new_task_name
  end

  test 'should destroy task' do
    assert_difference('Task.count', -1) do
      delete task_url(@task)
    end

    assert_redirected_to tasks_url
  end
end
