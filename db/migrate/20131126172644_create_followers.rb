class CreateFollowers < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.references :activity, index: true
      t.references :user, index: true
      t.string :role

      t.timestamps
    end
  end
end
