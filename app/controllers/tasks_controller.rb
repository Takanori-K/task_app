class TasksController < ApplicationController
  
  def new
    @user = User.find(params[:user_id])
    @task = @user.tasks.build
  end
  
  def index
    @user = User.find(params[:user_id])
    @tasks = @user.tasks.all.order(created_at: :desc)
  end
  
  def show
    @user = User.find(params[:user_id])
    @task = @user.tasks.find(params[:id])
  end
  
  def create
    @user = User.find(params[:user_id])
    @task = @user.tasks.build(task_params)
    if @task.save
      flash[:success] = "新規作成に成功しました。"
      redirect_to user_tasks_url
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:user_id])
    @task = @user.tasks.find(params[:id])
  end
  
  def update
    @user = User.find(params[:user_id])
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
      flash[:success] = "タスクを更新しました。"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
   @user = User.find(params[:user_id])
   @task = Task.find(params[:id])
   @task.destroy
    flash[:success] ="削除しました。"
    redirect_to user_tasks_url
  end
  
  private
    
    def task_params
      params.require(:task).permit(:task_name, :details, :user_id)
    end
end
