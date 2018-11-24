class AddBateriaToTransporte < ActiveRecord::Migration[5.2]
   def change
    add_column :transportes, :bateria, :integer
  end
end
