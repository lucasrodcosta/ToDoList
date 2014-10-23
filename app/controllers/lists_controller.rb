class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  respond_to :html, :js

  def index
    @lists = List.where(user: current_user).all
    respond_with(@lists)
  end

  def show
    respond_with(@list)
  end

  def new
    @list = List.new
    respond_with(@list)
  end

  def edit
    respond_with(@list)
  end

  def create
    @list = List.new(list_params)
    @list.user = current_user
    @list.save
    render js: "window.location = '/tasks?list=#{@list.id}'"
  end

  def update
    @list.update(list_params)
    render js: "window.location = '/tasks?list=#{@list.id}'"
  end

  def destroy
    @list.destroy
    respond_with(@list)
  end

  private
    def set_list
      @list = List.find(params[:id])
    end

    def list_params
      params[:list].permit!
    end
end
