class CreateLeituras < ActiveRecord::Migration[5.2]
  def change
    create_table :leituras do |t|
      t.string :umidade
      t.string :temperatura
      t.string :luminosidade
      t.string :ph

      t.timestamps
    end
  end
end
