class TasksController < ApplicationController 
  before_action :set_task, only:[:show, :edit, :update, :destroy]
  before_action :require_user_logged_in
  
  def index
    if logged_in?
      @user_tasks = current_user.tasks.all
    # @tasks = Task.all
    end
  end

  def show
    @user_task = current_user.tasks.find_by(id: params[:id])
  end

  def new
    @task = current_user.tasks.new
  end

  def create
    @task = current_user.tasks.new(task_parameters)
    if @task.save
      flash[:success] = 'タスクが正常に追加されました'
      redirect_to task_path(@task)
    else
      flash.now[:danger] = 'タスクの追加に失敗しました'
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_parameters)
      flash[:success] = 'taskは正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'taskの更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:success] = 'taskは正常に削除されました。'
    redirect_to tasks_url
  end
  
  private
  
  def task_parameters
    params.require(:task).permit(:content, :status, :user)
  end
  
  def set_task
    @task = Task.find(params[:id])
  end
  
end