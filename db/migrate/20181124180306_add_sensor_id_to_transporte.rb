class AddSensorIdToTransporte < ActiveRecord::Migration[5.2]
  def change
    add_column :transportes, :sensor_id, :integer
  end
end
