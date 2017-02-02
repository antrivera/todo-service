class AddUserIdToTodoItems < ActiveRecord::Migration
  def change
    add_column :todo_items, :user_id, :integer
    add_index :todo_items, :user_id
  end
end
