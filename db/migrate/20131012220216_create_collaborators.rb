class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :collaborators do |t|
      t.string :collaborator_type
      t.references :user
      t.references :project
      t.timestamps
    end
  end
end
