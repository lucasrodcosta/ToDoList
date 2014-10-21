class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  before_filter :authenticate_user!

  respond_to :html, :js

  def index
    @list = List.find(params[:list])
    @tasks = @list.tasks.all
    respond_with(@tasks)
  end

  def show
    respond_with(@task)
  end

  def new
    @task = Task.new
    @list = List.find(params[:list])
    respond_with(@task)
  end

  def edit
    @task = Task.find(params[:id])
    @list = @task.list
    respond_with(@task)
  end

  def create
    @task = Task.new(task_params)
    respond_with(@task, location: -> { tasks_path(list: @task.list) })
  end

  def update
    @task.update(task_params)
    respond_with(@task)
  end

  def destroy
    @task.destroy
    respond_with(@task)
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params[:task].permit!
    end
end
