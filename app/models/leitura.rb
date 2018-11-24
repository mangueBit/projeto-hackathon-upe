class Leitura < ApplicationRecord
    has_one :sensor
    has_one :transporte
end
