class SensorController < ApplicationController
  skip_before_action :verify_authenticity_token
  def register
    query = Sensor.find_by_code(params[:code])
    if query != nil
      sensor = query
    else
      sensor = Sensor.new(register_params)
    end
    sensor.save!
    render plain: "ok"
  end

  def update
    query = Sensor.find_by_code(params[:code])
    if query != nil
      leitura = query.leitura.new(leitura_params)
      leitura.sensor_id = params[:code]
      ActionCable.server.broadcast 'sensores',
        leitura.to_json
    end
    
    render status: 200
  end
  
  def register_params
    params.permit(:code,:local)
  end
  
  def leitura_params
    params.permit(:umidade,:temperatura,:luminosidade,:ph)
  end
end
