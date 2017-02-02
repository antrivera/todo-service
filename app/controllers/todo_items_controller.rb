class TodoItemsController < ApplicationController
  def index
    if params[:filtered]
      @todo_items = TodoItem.where(completed: false)
      render :index, locals: { filter: false }
    else
      @todo_items = TodoItem.all
      render :index, locals: { filter: true }
    end
  end

  def new
    @todo_item = TodoItem.new
  end

  def create
    @todo_item = TodoItem.create(todo_item_params)

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
    params.require(:todo_item).permit(:title, :completed)
  end
end