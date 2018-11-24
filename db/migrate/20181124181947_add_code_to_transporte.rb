class AddCodeToTransporte < ActiveRecord::Migration[5.2]
  def change
    add_column :transportes, :code, :string
  end
end
