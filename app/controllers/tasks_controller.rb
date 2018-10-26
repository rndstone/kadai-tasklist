class TasksController < ApplicationController 
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @tasks = Task.new
  end

  def create
    @tasks = Task.new(tasks_parameters)
    if @tasks.save
      flash[:sucess] = 'タスクが正常に追加されました'
      redirect_to @tasks
    else
      flash.now[:danger] = 'タスクの追加に失敗しました'
      render :new
    end
  end

  def edit
    @tasks = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(tasks_parameters)
      flash[:sucess] = 'taskは正常に更新されました'
      redirect_to @task
    else
      falsh.now[:danger] = 'taskの更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:sucess] = 'taskは正常に削除されました。'
    redirect_to tasks_url
  end
  
  private
  
  def tasks_parameters
    params.require(:task).permit(:content)
  end

end