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
    sensor = Sensor.find_by_code(params[:code_sensor])
    
    if !sensor.nil? && leitura_params[:tipo] == "in"
      return parseInRequest(params, transporte, sensor)
    elsif !sensor.nil? && leitura_params[:tipo] == "out"
     return parseOutRequest(params, transporte, sensor)
    end
    
    if transporte != nil && sensor != nil
      leitura = transporte.leitura.new(leitura_params)
      transporte.bateria = leitura.bateria_amount
      if transporte.used_time.nil?
        transporte.used_time = 1.seconds
      end
      transporte.ratio = rand(0..1)
      transporte.sensor_id = sensor.id
      transporte.save
      leitura.sensor_id = sensor.id
      ActionCable.server.broadcast 'sensores',
        (leitura.as_json.merge!({local: sensor.local, code: sensor.id})).to_json
    else
      
      
      if sensor.nil?
        sensor = Sensor.new
        sensor.code = params[:code_sensor]
        sensor.local = params[:sensor_coords]
        sensor.tipo = "estacao"
        sensor.save
      end
      
      if transporte.nil?
        transporte = Transporte.new
      end
      transporte.bateria = leitura_params[:bateria_amount]
      transporte.ratio = rand(0..1)
      transporte.sensor_id = sensor.id
      transporte.code = params[:code_transporte]
      transporte.save!
      
      transporte_leitura = transporte.leitura.new(leitura_params)
      transporte_leitura.sensor_id = sensor.id
      transporte_leitura.save!
      
      ActionCable.server.broadcast 'sensores',
        (transporte_leitura.as_json.merge!({local: sensor.local, code: sensor.id})).to_json
    end
      
      render plain: "okers"
  end
  
  def parseInRequest(params, transporte, sensor)
    transporte.sensor_id = nil
      transporte.bateria = leitura_params[:bateria_amount]
      transporte.save
      
      leitura = transporte.leitura.new(leitura_params)
      leitura.sensor_id = sensor.id
      leitura.save
      render plain: "okers" and return
  
  end
  
  def parseOutRequest(params, transporte, sensor)
     transporte.sensor_id = sensor.id
      transporte.bateria = leitura_params[:bateria_amount]
      transporte.save
      
      leitura = transporte.leitura.new(leitura_params)
      leitura.sensor_id = sensor.id
      leitura.save
      render plain: "okers" and return
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
    @leituras = Leitura.where("transporte_id = :transpId AND (tipo = :t1 OR tipo = :t2)", {t1:"in", t2: "out", transpId: params[:id]}).order(:created_at)
  end
  
  def leitura_params
    params.permit(:tipo,:bateria_amount)
  end
end
