class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy, :mark_as_done, :mark_as_undone]
  before_action :set_list, only: [:index, :new]

  respond_to :html, :js

  def index
    @tasks = @list.tasks.all if @list
    respond_with(@tasks)
  end

  def new
    @task = Task.new
    respond_with(@task)
  end

  def edit
    @list = @task.list
    respond_with(@task)
  end

  def create
    @task = Task.new(task_params)
    @list = @task.list

    begin
      @task.save!
    rescue Mongoid::Errors::Validations => ex
      flash[:error] = @task.errors.full_messages
    end

    render js: "window.location = '#{tasks_path(list: @list)}'"
  end

  def update
    @list = @task.list

    begin
      @task.update!(task_params)
    rescue Mongoid::Errors::Validations => ex
      flash[:error] = @task.errors.full_messages
    end

    render js: "window.location = '#{tasks_path(list: @list)}'"
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

    def set_list
      begin
        @list = current_user.lists.find(params[:list])
      rescue Mongoid::Errors::DocumentNotFound
        redirect_to root_path
      rescue Mongoid::Errors::InvalidFind
        redirect_to root_path
      end
    end

    def task_params
      params[:task].permit!
    end
end
