class Web::Tasks::AttachmentsController < Web::ApplicationController
  def download
    @task = Task.find(params[:task_id])

    send_file @task.attachment.path
  end
end