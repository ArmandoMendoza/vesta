class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.string :description
      t.date :init_date
      t.date :finish_date
      t.integer :execution_time
      t.string :unit_execution_time
      t.integer :percent_of_the_project
      t.string :state
      t.references :project, index: true
      t.timestamps
    end
  end
end
