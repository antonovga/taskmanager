require 'test_helper'

class Web::PagesControllerTest < ActionDispatch::IntegrationTest
  test 'should get home' do
    sign_in

    get pages_home_url
    assert_response :success
  end
end
