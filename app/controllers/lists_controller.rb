class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy, :mark_as_favorite, :unmark_as_favorite]

  respond_to :html, :js

  def index
    @lists = current_user.lists.all
    respond_with(@lists)
  end

  def show
    @tasks = @list.tasks
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

    begin
      @list.save!
    rescue Mongoid::Errors::Validations => ex
      flash[:error] = @list.errors.full_messages
      render js: "window.location = '#{lists_path}'"
    else
      render js: "window.location = '#{tasks_path(list: @list)}'"
    end
  end

  def update
    begin
      @list.update!(list_params)
    rescue Mongoid::Errors::Validations => ex
      flash[:error] = @list.errors.full_messages
      render js: "window.location = '#{lists_path}'"
    else
      render js: "window.location = '#{tasks_path(list: @list)}'"
    end
  end

  def destroy
    @list.destroy
    respond_with(@list)
  end

  def explore
    @lists = List.get_public_lists
    respond_with(@lists)
  end

  def mark_as_favorite
    @favorite = FavoriteList.new
    @favorite.list = @list
    @favorite.user = current_user
    @favorite.save
    respond_with(@favorite)
  end

  def unmark_as_favorite
    @favorite = FavoriteList.where(list: @list, user: current_user).first
    @favorite.destroy if @favorite
    respond_with(@favorite)
  end

  private
    def set_list
      @list = List.find(params[:id])
    end

    def list_params
      params[:list].permit!
    end
end
