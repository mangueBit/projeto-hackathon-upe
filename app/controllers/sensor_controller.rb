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
    @sensor
  end

  def update
    transporte = Transporte.find_by_code(params[:code_transporte])
    if transporte.nil?
      transporte = Transporte.new
    end
    sensor = Sensor.find_by_code(params[:code_sensor])
    if transporte != nil && sensor != nil
      leitura = transporte.leitura.new(leitura_params)
      leitura.sensor_id = transporte.id
      ActionCable.server.broadcast 'sensores',
        (leitura.as_json.merge!({local: sensor.local, code: params[:code_transporte]})).to_json
    else
      transporte_leitura = transporte.leitura.new(leitura_params)
      if sensor.nil?
        sensor = Sensor.new
        sensor.local = params[:sensor_coords]
        sensor.tipo = "estacao"
        sensor.save
      end
      sensor_leitura = sensor.leitura.new(leitura_params)
      sensor_leitura.save!
      transporte.sensor_id = sensor.id
      transporte.save!
      ActionCable.server.broadcast 'sensores',
        (sensor_leitura.as_json.merge!({local: sensor.local, code: params[:code_transporte]})).to_json
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
  
  def transporte_details
    @transporte = Transporte.find(params[:id])
  end
  
  def leitura_params
    params.permit(:tipo,:bateria_amount)
  end
end
