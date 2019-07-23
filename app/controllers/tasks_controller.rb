class TasksController < ApplicationController
  
  def new
    @task = Task.new
  end
  
  def index
    @tasks = Task.all
  end
end
