class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  before_filter :authenticate_user!

  responders :location, :flash
  respond_to :html

  def index
    @lists = List.all
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
  end

  def create
    @list = List.new(list_params)
    @list.save
    respond_with(@list, location: -> { tasks_path(list: @list) })
  end

  def update
    @list.update(list_params)
    respond_with(@list, location: -> { tasks_path(list: @list) })
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
