class Sensor < ApplicationRecord
    has_many :leitura
    has_many :transporte
end
