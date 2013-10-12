class CreateSubContractors < ActiveRecord::Migration
  def change
    create_table :sub_contractors do |t|
      t.string :name
      t.string :rif
      t.string :address
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
