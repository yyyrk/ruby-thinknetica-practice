require_relative 'train'

class PassengerTrain < Train
  attr_reader :type

  def initialize(number)
    super(number)
    @type = :passenger
  end

  def add_wagon(wagon)
    super if wagon.type == :passenger
  end
end