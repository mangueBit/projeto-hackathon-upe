class CreateSensorConfigs < ActiveRecord::Migration[5.2]
  def change
    create_table :sensor_configs do |t|
      t.string :configs
      t.string :sensor_id
      
      t.timestamps
    end
  end
end
