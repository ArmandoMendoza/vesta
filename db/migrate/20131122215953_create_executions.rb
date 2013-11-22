class CreateExecutions < ActiveRecord::Migration
  def change
    create_table :executions do |t|
      t.date :date
      t.integer :percent
      t.references :activity, index: true

      t.timestamps
    end
  end
end
