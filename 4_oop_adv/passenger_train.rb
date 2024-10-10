require_relative 'train'

class PassengerTrain < Train
  attr_reader :type

  def initialize(number)
    super
    @type = :passenger
  end

  protected

  def join_wagon?(wagon)
    wagon.is_a?(PassengerWagon)
  end
end