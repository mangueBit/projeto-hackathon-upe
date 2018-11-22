class ChangeCodeColumnSensor < ActiveRecord::Migration[5.2]
  def change
    change_column :sensors, :code, :string
  end
end
