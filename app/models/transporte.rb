class Transporte < ApplicationRecord
    has_one :sensor
    has_many :leitura
end
