require 'test_helper'

class Web::TasksHelperTest < ActionView::TestCase
  setup do
    @task = tasks(:regular_user_task)
  end

  test 'should return nothing if there is no attachment for task' do
    assert_dom_equal '', render_task_attachment(@task)
  end

  test 'should return image_tag if attachment mime type is image' do
    File.open('test/fixtures/files/pikachu.png') do |f|
      @task.attachment = f
    end

    @task.save

    assert_dom_equal image_tag(@task.attachment.url),
                     render_task_attachment(@task)
  end

  test 'should return download link if attachment mime type is non image' do
    File.open('test/fixtures/files/example.pdf') do |f|
      @task.attachment = f
    end

    @task.save

    assert_dom_equal link_to(@task.attachment.file.filename, download_user_task_attachment_path(@task)),
                     render_task_attachment(@task)
  end

  test 'should return links to transmit to available states' do
    assert_dom_equal link_to(:start, url_for([:start, :user, @task]), method: :patch),
                     render_task_state_links(@task)
  end
end