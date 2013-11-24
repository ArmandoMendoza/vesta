class AddColumnParentIdToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :parent_id, :integer, index: true
  end
end
