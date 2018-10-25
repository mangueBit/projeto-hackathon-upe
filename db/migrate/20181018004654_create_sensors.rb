class CreateSensors < ActiveRecord::Migration[5.2]
  def change
    create_table :sensors do |t|
      t.string :local
      t.string :tipo
      t.integer :user_id

      
      t.timestamps
    end
  end
end
