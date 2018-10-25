class AddSensorIdToLeitura < ActiveRecord::Migration[5.2]
  def change
    add_column :leituras, :sensor_id, :integer
  end
end
