require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:admin_user)
  end

  test 'should not save without email' do
    @user.email = nil

    assert_not @user.valid?
    assert_includes @user.errors, :email
  end

  test 'should have unique email' do
    user_copy = @user.dup

    assert_not user_copy.valid?
    assert_includes user_copy.errors, :email
  end

  test 'should not save without password' do
    @user.password = nil

    assert_not @user.valid?
    assert_includes @user.errors, :password
  end

  test 'should have two roles "user" and "admin" & right  mapping to int' do
    assert_equal User.role.values, %w(user admin)
  end

  test 'should have default role "user"' do
    user = User.new

    assert_equal user.role, 'user'
  end

  test 'should have many tasks' do
    user = User.create email: 'new_user@email.com', password: '123'
    2.times { user.tasks.create name: 'task name' }

    assert_equal user.tasks.count, 2
  end
end
