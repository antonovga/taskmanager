require 'test_helper'

class Web::TasksControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get tasks_path
    assert_response :success
  end
end
