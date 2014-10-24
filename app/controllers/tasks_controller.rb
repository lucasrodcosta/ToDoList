class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy, :mark_as_done, :mark_as_undone]

  respond_to :html, :js

  def index
    @list = List.find(params[:list])
    @tasks = @list.tasks.all
    respond_with(@tasks)
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
    list = @task.list
    @task.destroy
    redirect_to(tasks_path(list: list))
  end

  def mark_as_done
    @task.done = true
    @task.save
    respond_with(@task)
  end

  def mark_as_undone
    @task.done = false
    @task.save
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
