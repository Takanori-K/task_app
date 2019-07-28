class TasksController < ApplicationController
  
  def new
    @task = Task.new
  end
  
  def index
    @tasks = Task.all
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = "新規作成に成功しました。"
      redirect_to task_url user
    else
      render 'new'
    end
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:success] ="削除しました。"
    redirect_to tasks_url
  end
  
  private
    
    def task_params
      params.require(:task).permit(:task_name, :details, :user_id)
    end
end
