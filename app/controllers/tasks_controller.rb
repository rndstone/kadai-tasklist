class TasksController < ApplicationController 
  before_action :set_task, only:[:show, :edit, :update, :destroy]
  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_parameters)
    if @task.save
      flash[:sucess] = 'タスクが正常に追加されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクの追加に失敗しました'
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_parameters)
      flash[:sucess] = 'taskは正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'taskの更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:sucess] = 'taskは正常に削除されました。'
    redirect_to tasks_url
  end
  
  private
  
  def task_parameters
    params.require(:task).permit(:content, :status)
  end
  
  def set_task
    @task = Task.find(params[:id])
  end
end