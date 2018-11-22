class SensorController < ApplicationController
  skip_before_action :verify_authenticity_token
  def register
    query = Sensor.find_by_code(params[:code])
    if query != nil
      sensor = query
      sensor.update(register_params)
    else
      sensor = Sensor.new(register_params)
      sensor.save!
    end
    render plain: "ok"
  end
  
  def details
    @sensor = Sensor.find(params[:sensor_id])
    p @sensor
  end

  def update
    query = Sensor.find_by_code(params[:code])
    p query
    if query != nil
      leitura = query.leitura.new(leitura_params)
      leitura.sensor_id = query.id
      ActionCable.server.broadcast 'sensores',
        (leitura.as_json.merge!({local: query.local, code: params[:code]})).to_json
    else
      raise "sensor não encontrado. Disparar erro para reiniciar registro"
    end
      
      render plain: "okers"
  end
  
  def register_params
    params.permit(:code,:local)
  end
  
  def configuration
    sensor = Sensor.find(params[:sensor_id])
    configs = sensor.sensor_config.all
    if configs.size > 0
      conf = configs[0]
    else
      conf = sensor.sensor_config.new
    end
  end
  
  def leitura_params
    params.permit(:umidade,:temperatura,:luminosidade,:ph)
  end
end
