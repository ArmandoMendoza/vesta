class CreateJoinTableTaskUser < ActiveRecord::Migration
  def change
    create_join_table :tasks, :users do |t|
      t.index :task_id
      t.index :user_id
    end
  end
end
