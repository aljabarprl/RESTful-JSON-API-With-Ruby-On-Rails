class RenameCreatedByToUserIdInTodos < ActiveRecord::Migration[8.1]
  def change
    rename_column :todos, :created_by, :user_id
  end
end
