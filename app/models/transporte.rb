class Transporte < ApplicationRecord
    belongs_to :sensor
    has_many :leitura
end
