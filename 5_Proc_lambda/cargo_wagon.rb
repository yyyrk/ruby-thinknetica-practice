require_relative 'wagon'
require_relative 'validations'

class CargoWagon < Wagon
  def initialize(number, volume)
    super(number, 'cargo', volume)
    validate!
  end

  def load_cargo(volume)
    if volume_free >= volume
      super(volume)
    else
      puts "Недостаточно свободного объема!"
    end
  end

  def volume_free
    unbusy
  end

  def volume
    amount
  end

  def unload_cargo(volume)
    if volume <= busy
      super(-volume)
    else
      puts "Не удалось разгрузить, в вагоне меньше груза, чем вы пытаетесь выгрузить!"
    end
  end

  private

  def validate!
    raise ArgumentError, "Номер вагона не может быть пустым" if @number.nil? || @number.empty?
    raise ArgumentError, "Тип вагона не может быть пустым" if @type.nil? || @type.empty?
    raise ArgumentError, "Объем не может быть равен нулю" if @amount.to_i <= 0
  end

  def valid?
    validate!
    true
  rescue StandardError => err
    puts "Произошла ошибка при валидации вагона: #{err.message} (#{self.class})"
    false
  end
end