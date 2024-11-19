require_relative 'wagon'
require_relative 'validations'

class CargoWagon < Wagon
  def initialize(number, volume)
    super(number,"cargo", volume)
    validate!
  end

  def load_cargo(volume_load)
    fill(volume_load)
  end

  def volume_unfree
    busy
  end

  def volume_free
    unbusy
  end

  def volume
    amount
  end

  def unload_cargo(volume_unload)
    fill(-volume_unload)
  end

  private

  def validate!
    raise ArgumentError, "Число не может быть равно нулю" if @number.nil?
    raise ArgumentError, "Тип не может быть равен нулю" if @type.nil?
  end

  def valid?
    validate!
    true
  rescue StandardError => err
    puts "Произошла ошибка класса #{err.class.name}: #{err.message}"
    false
  end
end
