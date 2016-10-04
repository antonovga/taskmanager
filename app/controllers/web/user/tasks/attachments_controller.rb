class Web::User::Tasks::AttachmentsController < Web::User::ApplicationController
  def download
    @task = Task.find(params[:task_id])

    send_file @task.attachment.path
  end
end