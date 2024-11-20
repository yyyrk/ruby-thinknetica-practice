require_relative 'wagon'
require_relative 'validations'

class PassengerWagon < Wagon
  def initialize(number, places)
    super(number,'passenger', places)
    validate!
  end

  def take_place
    fill(1)
  end

  def busy_places
    busy
  end

  def unbusy_places
    unbusy
  end

  def total_places
    amount
  end

  def free_place
    fill(-1)
  end

  def take_place
    if unbusy > 0
      @busy += 1
      @unbusy -= 1
    else
      puts "Нет свободных мест!"
    end
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
