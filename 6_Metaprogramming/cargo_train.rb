require_relative 'train'
require_relative 'accessors'

class CargoTrain < Train
  attr_reader :type

  def initialize(number)
    super
    @type = :cargo
  end

  def add_wagon(wagon)
    super(wagon) if wagon.type == :cargo
  end
end