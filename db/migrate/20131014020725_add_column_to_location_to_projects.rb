class AddColumnToLocationToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :address, :string
    add_column :projects, :address_city, :string
    add_column :projects, :address_municipality, :string
    add_column :projects, :address_state, :string
    add_column :projects, :latitude, :float
    add_column :projects, :longitude, :float
  end
end
