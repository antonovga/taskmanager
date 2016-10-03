require 'test_helper'

class Web::Tasks::AttachmentsControllerTest < ActionDispatch::IntegrationTest
  test 'should download attachment file' do
    @task = tasks(:regular_user_task)

    File.open('test/fixtures/files/example.pdf') do |f|
      @task.attachment = f
    end

    @task.save

    sign_in
    get download_task_attachment_path(@task)

    assert_response :success
    assert_equal MIME::Types.type_for(@task.attachment.file.filename).first&.to_s || 'application/octet-stream',
                 response.content_type
  end
end
