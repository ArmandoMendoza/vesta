class RenameColumnCompleteInTasks < ActiveRecord::Migration
  def change
    rename_column :tasks, :complete, :completed
  end
end
