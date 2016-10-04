class Web::User::Tasks::AttachmentsController < Web::User::ApplicationController
  def download
    @task = current_user.tasks.find(params[:task_id])

    send_file @task.attachment.path
  end
end