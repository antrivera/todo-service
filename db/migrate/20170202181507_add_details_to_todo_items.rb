class AddDetailsToTodoItems < ActiveRecord::Migration
  def change
    add_column :todo_items, :details, :text
  end
end
