class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

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
    @list = @task.list
    respond_with(@task)
  end

  def create
    @task = Task.new(task_params)
    @task.save
    @list = @task.list
    render js: "window.location = '/tasks?list=#{@list.id}'"
  end

  def update
    @task.update(task_params)
    @list = @task.list
    render js: "window.location = '/tasks?list=#{@list.id}'"
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
