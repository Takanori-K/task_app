class TasksController < ApplicationController
  
  before_action :logged_in_user, only: [:new, :index, :show, :create, :edit, :update, :destroy]
  before_action :access_the_edit_page_as_a_non_logged_in_user, only: :edit
  before_action :correct_user,   only: [:new, :index, :show, :create, :edit, :update, :destroy]
  
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
      redirect_to user_task_url(@user)
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
    
    def access_the_edit_page_as_a_non_logged_in_user
      @user = User.find(params[:user_id]) if @user.blank?
      unless current_user?(@user)
        flash[:danger] = "編集権限がありません。"
        redirect_to user_tasks_url(@user)
      end
    end
end
