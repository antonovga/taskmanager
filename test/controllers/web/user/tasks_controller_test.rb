require 'test_helper'

class Web::User::TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in
    @task = tasks(:regular_user_task)
  end

  test 'should get index' do
    get user_tasks_path
    assert_response :success
  end

  test 'should get new' do
    get new_user_task_path
    assert_response :success
  end

  test 'should get edit' do
    get edit_user_task_url(@task)
    assert_response :success
  end

  test 'should create task' do
    assert_difference('Task.count') do
      post user_tasks_url, params: { task: { name: 'new_task' } }
    end

    assert_redirected_to user_tasks_path
  end

  test 'should render #new if create failed' do
    post user_tasks_url, params: { task: { name: '' } }

    assert_template :new
  end

  test 'should update task' do
    new_task_name = 'update name'
    patch user_task_url(@task), params: { task: { name: new_task_name } }
    @task.reload

    assert_redirected_to user_tasks_path
    assert_equal @task.name, new_task_name
  end

  test 'should render #new if update failed' do
    patch user_task_url(@task), params: { task: { name: '' } }

    assert_template :edit
  end

  test 'should destroy task' do
    assert_difference('Task.count', -1) do
      delete user_task_url(@task)
    end

    assert_redirected_to user_tasks_url
  end

  test 'should save attachment on create' do
    task_params = { task: { name: 'new_task_with_image',
                            attachment: fixture_file_upload('files/pikachu.png', 'image/png')
    }
    }
    post user_tasks_url, params: task_params

    assert Task.last.attachment
    assert File.exists?(Task.last.attachment.file.path)
  end

  test 'should save image on create' do
    task_params = { task: { name: 'new_task_with_image',
                            attachment: fixture_file_upload('files/pikachu.png', 'image/png')
                          }
                  }
    post user_tasks_url, params: task_params

    assert FileUtils.compare_file('test/fixtures/files/pikachu.png', Task.last.attachment.file.path)
  end

  test 'should save pdf on create' do
    task_params = { task: { name: 'new_task_with_image',
                            attachment: fixture_file_upload('files/example.pdf', 'image/png')
                          }
                  }
    post user_tasks_url, params: task_params

    assert FileUtils.compare_file('test/fixtures/files/example.pdf', Task.last.attachment.file.path)
  end

  test 'should save attachment on update' do
    task_params = { task: { attachment: fixture_file_upload('files/pikachu.png', 'image/png') } }
    patch user_task_url(@task), params: task_params

    @task.reload

    assert @task.attachment.file
    assert File.exists?(@task.attachment.file.path)
  end

  test 'should save image on update' do
    task_params = { task: { attachment: fixture_file_upload('files/pikachu.png', 'image/png') } }
    patch user_task_url(@task), params: task_params

    @task.reload

    assert FileUtils.compare_file('test/fixtures/files/pikachu.png', @task.attachment.file.path)
  end

  test 'should save pdf on update' do
    task_params = { task: { attachment: fixture_file_upload('files/example.pdf', 'image/png') } }
    patch user_task_url(@task), params: task_params

    @task.reload

    assert FileUtils.compare_file('test/fixtures/files/example.pdf', @task.attachment.file.path)
  end

  test 'should remove attachment on update if remove_attachment checked' do
    task_params = { task: { attachment: fixture_file_upload('files/example.pdf', 'image/png') } }
    patch user_task_url(@task), params: task_params

    @task.reload

    assert Task.last.attachment.file

    patch user_task_url(@task), params: { task: { remove_attachment: true } }

    @task.reload

    assert_not Task.last.attachment.file
  end

  test 'should change state to started' do
    patch start_user_task_path(@task)

    @task.reload

    assert @task.started?
    assert_redirected_to user_tasks_path
  end

  test 'should change state to finished' do
    @task.start!

    patch finish_user_task_path(@task)

    @task.reload

    assert @task.finished?
    assert_redirected_to user_tasks_path
  end

  test 'should not change state to finished if task not started' do
    patch finish_user_task_path(@task)

    @task.reload

    assert_not @task.finished?
    assert @task.new?
    assert_redirected_to user_tasks_path
  end

end
