class AddCodeToSensor < ActiveRecord::Migration[5.2]
  def change
    add_column :sensors, :code, :integer
  end
end
