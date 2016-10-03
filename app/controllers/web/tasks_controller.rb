class Web::TasksController < Web::ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :start, :finish]

  def index
    @tasks = current_user.tasks.order(created_at: :desc)
  end

  def show
  end

  def new
    @task = current_user.tasks.new
  end

  def edit
  end

  def create
    @task = current_user.tasks.new(task_params)

    if @task.save
      redirect_to tasks_path
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def destroy
    @task.destroy

    redirect_to tasks_url
  end

  def start
    @task.start!

    redirect_to tasks_path
  end

  def finish
    @task.finish!

    redirect_to tasks_path
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :attachment, :remove_attachment)
  end
end
