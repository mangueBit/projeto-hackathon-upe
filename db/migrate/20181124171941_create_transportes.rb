class CreateTransportes < ActiveRecord::Migration[5.2]
  def change
    create_table :transportes do |t|
      t.string :used_time
      t.string :history
      t.string :ratio

      t.timestamps
    end
  end
end
