class Add < ActiveRecord::Migration[5.2]
  def change
    add_column :leituras, :transporte_id, :integer
  end
end
