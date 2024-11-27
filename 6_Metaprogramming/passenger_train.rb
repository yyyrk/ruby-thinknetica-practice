# frozen_string_literal: true
require_relative 'accessors'
require_relative 'train'

class PassengerTrain < Train
  attr_reader :type

  def initialize(number)
    super(number)
    @type = :passenger
  end

  def add_wagon(wagon)
    super(wagon) if wagon.type == 'Passenger'
  end
end
