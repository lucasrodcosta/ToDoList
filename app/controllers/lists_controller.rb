class ListsController < ApplicationController
  before_action :set_list, only: [:edit, :update, :destroy, :mark_as_favorite, :unmark_as_favorite]

  respond_to :html, :js

  def index
    @lists = current_user.lists.all
    respond_with(@lists)
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
