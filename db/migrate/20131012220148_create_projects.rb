class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :contract_number
      t.date :init_date
      t.date :finish_date
      t.float :budget
      t.float :advance
      t.string :state
      t.references :contractor
      t.references :sub_contractor
      t.timestamps
    end
  end
end
