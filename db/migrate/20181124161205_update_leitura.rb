class UpdateLeitura < ActiveRecord::Migration[5.2]
  def change
    remove_column :leituras, :umidade
    remove_column :leituras, :temperatura
    remove_column :leituras, :luminosidade
    remove_column :leituras, :ph
    add_column :leituras, :tipo, :string
    add_column :leituras, :bateria_amount, :string
  end
end
