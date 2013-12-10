class AddColumnsUploadedByAndPublishToImages < ActiveRecord::Migration
  def change
    add_column :images, :uploaded_by, :integer
    add_column :images, :publish, :boolean, default: false
  end
end
