class TodoItemsController < ApplicationController
  before_action :require_current_user!
  before_filter :require_item_ownership!, only: [:show, :edit, :destroy, :update]

  def index
    if params[:search]
      @todo_items = TodoItem.search(params[:search], current_user)
      render :index, locals: { filter: true, display_back_link: true }
    elsif params[:filtered]
      @todo_items = current_user.todo_items.filtered
      render :index, locals: { filter: false, display_back_link: false }
    else
      @todo_items = current_user.todo_items
      render :index, locals: { filter: true, display_back_link: false }
    end
  end

  def new
    @todo_item = TodoItem.new
  end

  def create
    @todo_item = current_user.todo_items.new(todo_item_params)

    if @todo_item.save
      redirect_to todo_items_url
    else
      flash.now[:errors] = @todo_item.errors.full_messages
      render :new
    end
  end

  def edit
    @todo_item = TodoItem.find(params[:id])
  end

  def update
    @todo_item = TodoItem.find(params[:id])

    if @todo_item.update(todo_item_params)
      redirect_to @todo_item
    else
      flash.now[:errors] = @todo_item.errors.full_messages
      render :edit
    end
  end

  def show
    @todo_item = TodoItem.find(params[:id])
  end

  def destroy
    @todo_item = TodoItem.find(params[:id])
    @todo_item.destroy
    redirect_to todo_items_url
  end

  private

  def todo_item_params
    params.require(:todo_item).permit(:title, :completed, :details)
  end

  def require_item_ownership!
    return if current_user.id == TodoItem.find(params[:id]).user_id
    redirect_to todo_items_url
  end
end
