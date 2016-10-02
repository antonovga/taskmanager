require 'test_helper'

class Web::Auth::SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get new_auth_session_path
    assert_response :success
  end

  test 'should login valid user' do
    user = users(:regular_user)
    post auth_sessions_path({ session: { email: user.email, password: '12345678' } })

    assert_equal session[:user_id], user.id
    assert_redirected_to root_path
  end

  test 'should redirect invalid user to login form' do
    user = users(:regular_user)
    post auth_sessions_path({ session: { email: user.email, password: 'invalid' } })

    assert_equal session[:user_id], nil
    assert_redirected_to new_auth_session_path
  end

  test 'should log out user on #destroy' do
    delete auth_sessions_destroy_path
    assert_equal session[:user_id], nil
    assert_redirected_to new_auth_session_path
  end
end
